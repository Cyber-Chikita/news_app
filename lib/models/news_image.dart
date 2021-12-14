const _typeLabel = "_type";
const _thumbnailLabel = "thumbnail";
const _urlLabel = "url";

class NewsImage {
  final String? type;
  final String? url;

  NewsImage(this.type, this.url);

  NewsImage.fromJson(Map<String, dynamic> json)
      : type = json[_typeLabel],
        url = json[_urlLabel];
}

class ImageThumbnail {
  final String? type;
  final String? url;

  ImageThumbnail(this.type, this.url);

  ImageThumbnail.fromJson(Map<String, dynamic> json)
      : type = json[_typeLabel],
        url = json[_urlLabel];
}
