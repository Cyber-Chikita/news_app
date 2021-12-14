import 'package:news_app/models/news_image.dart';

const _typeLabel = "_type";
const _nameLabel = "name";
const _descriptionLabel = "description";
const _urlLabel = "url";
const _imageLabel = "image";

class News {
  final String type;
  final String name;
  final String? description;
  final String? url;
  final NewsImage image;

  News(
    this.type,
    this.name,
    this.image,
    this.url, {
    this.description,
  });

  News.fromJson(Map<String, dynamic> json)
      : type = json[_typeLabel],
        name = json[_nameLabel],
        description = json[_descriptionLabel],
        url = json[_urlLabel],
        image = NewsImage.fromJson(json[_imageLabel] ?? {});

  static List<News> fromJsonList(List<dynamic> jsonList) {
    List<News> news = [];
    for (var element in jsonList) {
      news.add(News.fromJson(element));
    }
    return news;
  }
}
