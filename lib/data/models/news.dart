import 'package:intl/intl.dart';
import 'package:news_app/core/utils/constants.dart';

class News {
  
  final int? id;
  final String title;
  final String publishedAt;
  final String urlToImage;
  final String url;

  News({
    this.id,
    required this.title,
    required this.publishedAt,
    required this.urlToImage,
    required this.url
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json[ARTICLE_ID],
    title: json[ARTICLE_TITLE],
    publishedAt: DateFormat('d / MM / yyyy AT hh:mm a').format(DateTime.parse(json[ARTICLE_DATE])),
    urlToImage: json[ARTICLE_IMAGE] ?? PLACEHOLDER_IMAGE,
    url: json[ARTICLE_URL],
  );

  Map<String, dynamic> toJson() => {
    ARTICLE_ID: id,
    ARTICLE_TITLE: title,
    ARTICLE_DATE: publishedAt,
    ARTICLE_IMAGE: urlToImage,
    ARTICLE_URL: url,
  };

}