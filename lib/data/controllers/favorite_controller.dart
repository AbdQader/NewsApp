import 'package:get/get.dart';
import '/data/providers/db_provider.dart';
import '/data/models/news.dart';

class FavoriteController extends GetxController {

  // Lists to Set "favorites news" and "favorites news urls"
  List<News> _favoritesNews = [];
  List<String> _favoritesUrls = [];
  
  // Lists to Get the "favorites news" and "favorites news urls"
  List<News> get getFavoritesNews => _favoritesNews;
  List<String> get getFavoritesUrls => _favoritesUrls;

  // To check the loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    // Call "fetchFavoritesNews" function
    fetchFavoritesNews();
    // Call "fetchFavoritesUrls" function
    fetchFavoritesUrls();
  }
  
  // This function to fetch the favorites articles from the database
  Future<void> fetchFavoritesNews() async {
    _isLoading = true;
    final articles = await DBProvider.dbProvider.getArticles();
    articles!.forEach((news) {
      _favoritesNews.insert(0, news);
    });
    _isLoading = false;
    update();
  }

  // This function to insert new article in the database
  Future<void> addNewsToFavorite(News news, [int? index]) async {
    await DBProvider.dbProvider.insertNews(news);
    _favoritesNews.insert(index!, news);
    _favoritesUrls.add(news.url);
    update();
  }

  // This function to delete the article from the database
  Future<void> removeNewsFromFavorite(News news) async {
    await DBProvider.dbProvider.deleteNews(news);
    _favoritesNews.remove(news);
    _favoritesUrls.remove(news.url);
    update();
  }

  // this function to fetch all favorites articles urls from database
  Future<void> fetchFavoritesUrls() async {
    final articles = await DBProvider.dbProvider.getArticles();
    articles!.forEach((news) {
      _favoritesUrls.add(news.url);
    });
    update();
  }

}