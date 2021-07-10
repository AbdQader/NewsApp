import 'package:get/get.dart';
import '/data/providers/api_provider.dart';
import '/data/models/news.dart';

class SearchController extends GetxController {

  // List to hold the searched news
  var searchedNews = <News>[].obs;

  // To check the loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // This function to get the searched news from "ApiProvider"
  Future<void> searchForNews(String search) async {
    _isLoading = true;
    await ApiProvider.searchForNews(search)
      .then((news) {
        if (news.isNotEmpty) {
          searchedNews.value = news;
        }
        _isLoading = false;
      })
      .catchError((error) {
        print('abd => getSearchedNews Error: $error');
        _isLoading = false;
      });
    update();
  }

}