import 'package:news_app/utils/constraints.dart';

const _countLabel = "count";
const _offsetLabel = "offset";
const _sincelabel = "since";
const _langLabel = "setLang";
const _mktLabel = "mkt";
const _ccLabel = "cc";
const _textFormatLabel = "textFormat";
const _safeSearchLabel = "safeSearch";

class NewsQuery {
  final int count;
  final int offset;
  final int since;
  final String lang = "EN";
  final String mkt = "en-US";
  final String cc = "us";
  final String textFormat = "Raw";
  final String safeSearch = "Off";

  NewsQuery({
    required this.since,
    this.count = newsCount,
    this.offset = 0,
  });

  String get query {
    if (count <= 0) throw Exception("Count must be greater than 0");
    if (offset < 0) {
      throw Exception("Offset must be greater than or equal to 0");
    }
    if (since < 0) throw Exception("Offset must be greater than or equal to 0");
    String query =
        "?$_countLabel=$count&$_offsetLabel=$offset&$_sincelabel=$since&$_langLabel=$lang&"
        "$_mktLabel=$mkt&$_textFormatLabel=$textFormat&$_safeSearchLabel=$safeSearch&$_ccLabel=$cc";
    return query;
  }
}
