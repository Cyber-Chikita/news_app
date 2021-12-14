import 'package:dio/dio.dart';
import 'package:news_app/models/news_list.dart';
import 'package:news_app/models/news_query.dart';
import 'package:news_app/utils/api_client.dart';

class NewsRepository {
  static const _trendingTopicsEndpoint = "/news/trendingtopics";

  Future<NewsList> fetchNews(NewsQuery newsQuery) async {
    final Response response =
        await ApiClient.dio.get("$_trendingTopicsEndpoint${newsQuery.query}");
    print(response.data);
    return NewsList.fromJson(response.data);
  }
}
