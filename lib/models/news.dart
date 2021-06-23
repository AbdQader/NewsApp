class News {
  
  final int? id;
  final String? title;
  final String? publishedAt;
  final String? urlToImage;
  final String? url;

  News({
    this.id,
    this.title,
    this.publishedAt,
    this.urlToImage,
    this.url
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    publishedAt: json["publishedAt"],
    urlToImage: json["urlToImage"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "publishedAt": publishedAt,
    "urlToImage": urlToImage,
    "url": url,
  };

}