import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import '../database/db_helper.dart';
import '../models/news.dart';

class NewsController extends GetxController {

  // API URL
  String _apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&page=1&apiKey=6773d54ff4a145adb2cdb6096daab486';

  // For unavailable news image
  String placeholderImage = 'https://www.asanet.org/sites/default/files/default_images/placeholder-news.jpg';
  
  // Lists to Set "news", "searched news", "favorites news" and "favorites news urls"
  List<News> _news = [];
  List<News> _searchedNews = [];
  List<News> _favoritesNews = [];
  List<String> _favoritesUrls = [];
  
  // Lists to Get the "news", "searched news", "favorites news" and "favorites news urls"
  List<News> get getNews => _news;
  List<News> get getSearchedNews => _searchedNews;
  List<News> get getFavoritesNews => _favoritesNews;
  List<String> get getFavoritesUrls => _favoritesUrls;

  @override
  void onInit() {
    super.onInit();
    // call "fetchNews" function
    fetchNews();
    // call "fetchFavoritesNews" function
    fetchFavoritesNews();
    // call "fetchFavoritesUrls" function
    fetchFavoritesUrls();
  }

  // This function to fetch the articles from the API
  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final newsData = json.decode(response.body) as Map<String, dynamic>;
        newsData['articles'].forEach((article) {
          _news.add(
            News(
              title: article['title'], 
              publishedAt: article['publishedAt'], 
              urlToImage: article['urlToImage'] ?? placeholderImage, 
              url: article['url'],
            )
          );
        });
      } else {
        Get.snackbar(
          'An Error Occurred!!', 
          'something went wrong try again later!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      update();
    } catch(e) {
      throw e;
    }
  }

  // This function to fetch the searched articles from the API
  Future<void> searchForNews(String search) async {
    if (search.isEmpty) return;
    String _searchUrl = 'https://newsapi.org/v2/everything/?q=$search&apiKey=6773d54ff4a145adb2cdb6096daab486';
    try {
      final response = await http.get(Uri.parse(_searchUrl));
      if (response.statusCode == 200) {
        final newsData = json.decode(response.body) as Map<String, dynamic>;
        _searchedNews.clear();
        newsData['articles'].forEach((article) {
          _searchedNews.add(
            News(
              title: article['title'], 
              publishedAt: article['publishedAt'], 
              urlToImage: article['urlToImage'] ?? placeholderImage, 
              url: article['url'],
            )
          );
        });
      } else {
        Get.snackbar(
          'An Error Occurred!!', 
          'something went wrong try again later!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      update();
    } catch(e) {
      throw e;
    }
  }

  // This function to fetch the favorites articles from the database
  Future<void> fetchFavoritesNews() async {
    final articles = await DBHelper.dbHelper.getArticles();
    articles!.forEach((news) {
      _favoritesNews.insert(0, news);
    });
    update();
  }

  // This function to insert new article in the database
  Future<void> addNewsToFavorite(News news, [int? index]) async {
    await DBHelper.dbHelper.insertNews(news);
    _favoritesNews.insert(index!, news);
    _favoritesUrls.add(news.url!);
    update();
  }

  // This function to delete the article from the database
  Future<void> removeNewsFromFavorite(News news) async {
    await DBHelper.dbHelper.deleteNews(news);
    _favoritesNews.remove(news);
    _favoritesUrls.remove(news.url!);
    update();
  }

  // this function to fetch all favorites articles urls from database
  Future<void> fetchFavoritesUrls() async {
    final articles = await DBHelper.dbHelper.getArticles();
    articles!.forEach((news) {
      _favoritesUrls.add(news.url!);
    });
    update();
  }

}