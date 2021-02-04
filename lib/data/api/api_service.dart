import 'dart:convert';

import 'package:dicoding_news_app/data/model/api_article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '10eb3f188a854b7c84ace080c6db4a6c';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ApiArticle> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return ApiArticle.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top Headlines');
    }
  }
}
