import 'package:news_app/models/news.dart';

const _typeLabel = "_type";
const _webSearchUrlLabel = "webSearchUrl";
const _newsLabel = "value";

class NewsList {
  final String type;
  final String webSearchUrl;
  final List<News> news;

  NewsList(this.type, this.webSearchUrl, this.news);

  NewsList.fromJson(Map<String, dynamic> json)
      : type = json[_typeLabel] ?? "undefined",
        webSearchUrl = json[_webSearchUrlLabel] ?? "undefined",
        news = News.fromJsonList(json[_newsLabel]);
}
