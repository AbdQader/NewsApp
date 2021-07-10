import 'dart:convert';
import 'package:http/http.dart' as http;
import '/data/models/news.dart';
import '/core/utils/constants.dart';

class ApiProvider {

  // This function to fetch the news articles from the API
  static Future<List<News>> fetchNews() async {
    final List<News> news = [];
    await http.get(Uri.parse(API_URL))
      .then((response) {
        final newsData = json.decode(response.body) as Map<String, dynamic>;
        news.clear();
        newsData['articles'].forEach((article) {
          news.add(News.fromJson(article));
        });
      }).catchError((error) {
        throw error;
      });
      return news;
  }

  // This function to fetch the searched news articles from the API
  static Future<List<News>> searchForNews(String search) async {
    final List<News> searchedNews = [];
    if (search.trim().isEmpty) return [];
    String _searchUrl = 'https://newsapi.org/v2/everything/?q=$search&apiKey=$API_KEY';
    await http.get(Uri.parse(_searchUrl))
      .then((response) {
        final newsData = json.decode(response.body) as Map<String, dynamic>;
        searchedNews.clear();
        newsData['articles'].forEach((article) {
          searchedNews.add(News.fromJson(article));
        });
      })
      .catchError((error) {
        throw error;
      });
    return searchedNews;
  }

}