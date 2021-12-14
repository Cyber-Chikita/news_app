part of './news_list_bloc.dart';

abstract class NewsListState extends Equatable {}

class NewsListLoading extends NewsListState {
  @override
  List<Object?> get props => [];
}

class NewsListNextLoading extends NewsListState {
  @override
  List<Object?> get props => [];
}

class NewsListLoaded extends NewsListState {
  final int requestDate;
  final List<News> news;
  final bool isNewDataExist;

  NewsListLoaded(this.requestDate, this.news, {this.isNewDataExist = true});
  @override
  List<Object?> get props => [
        requestDate,
        news,
        isNewDataExist,
      ];
}

class NewsListError extends NewsListState {
  final String error;

  NewsListError(this.error);

  @override
  List<Object?> get props => [error];
}
