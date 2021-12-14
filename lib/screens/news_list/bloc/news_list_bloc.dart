import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/models/news_list.dart';
import 'package:news_app/models/news_query.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/utils/api_client.dart';

part './news_list_event.dart';
part './news_list_state.dart';

extension on DateTime {
  int get secondSinceEpoch => millisecondsSinceEpoch ~/ 1000;
}

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc(NewsListState initialState, this._newsRepository)
      : super(initialState) {
    on<UpdateRequested>(_onUpdateRequested);
    on<LoadNextRequested>(_onLoadNextRequested);
  }

  final NewsRepository _newsRepository;

  void _onUpdateRequested(
      UpdateRequested event, Emitter<NewsListState> emit) async {
    try {
      emit(NewsListLoading());
      int nowDate = DateTime.now().secondSinceEpoch;
      NewsList newsList =
          await _newsRepository.fetchNews(NewsQuery(since: nowDate));
      emit(NewsListLoaded(nowDate, newsList.news));
    } catch (e, st) {
      print(e);
      print(st);
      emit(NewsListError(ApiClient.handleNetworkError(e)));
    }
  }

  void _onLoadNextRequested(
      LoadNextRequested event, Emitter<NewsListState> emit) async {
    NewsListState previousState = state;
    if (previousState is NewsListLoaded && previousState.isNewDataExist) {
      try {
        emit(NewsListNextLoading());
        NewsList newsList = await _newsRepository.fetchNews(NewsQuery(
          since: previousState.requestDate,
          offset: previousState.news.length,
        ));
        emit(NewsListLoaded(
          previousState.requestDate,
          [...previousState.news, ...newsList.news],
          isNewDataExist: newsList.news.length == 10,
        ));
      } catch (e) {
        emit(NewsListError(ApiClient.handleNetworkError(e)));
      }
    } else {
      add(UpdateRequested());
    }
  }
}
