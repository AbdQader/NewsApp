import 'package:get/get.dart';
import '/data/providers/api_provider.dart';
import '/data/models/news.dart';

class SearchController extends GetxController {

  // List to hold the searched news
  var searchedNews = <News>[].obs;

  // For Search Text
  Rx<String> search = ''.obs;

  // To check the loading state
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Call the 'searchForNews' method after the search variable changes with 3 seconds.
    debounce(search, (_) => searchForNews(), time: Duration(seconds: 3));
  }

  Future<void> searchForNews() async {
    isLoading.value = true;
    await ApiProvider.searchForNews(search.value)
      .then((news) {
        if (news.isNotEmpty) {
          searchedNews.value = news;
        }
        isLoading.value = false;
      })
      .catchError((error) {
        print('abd => getSearchedNews Error: $error');
        isLoading.value = false;
      });
  }

}