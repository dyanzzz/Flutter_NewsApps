// https://app.quicktype.io/

import 'dart:convert';

import 'package:dicoding_news_app/data/model/article.dart';

ApiArticle apiArticleFromJson(String str) =>
    ApiArticle.fromJson(json.decode(str));

String apiArticleToJson(ApiArticle data) => json.encode(data.toJson());

class ApiArticle {
  ApiArticle({
    this.status,
    this.totalResults,
    this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory ApiArticle.fromJson(Map<String, dynamic> json) => ApiArticle(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
