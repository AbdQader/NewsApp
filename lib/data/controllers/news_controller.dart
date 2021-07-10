import 'package:get/get.dart';
import '/data/providers/api_provider.dart';
import '/data/models/news.dart';

class NewsController extends GetxController {

  // List to Set "news" & List to Get the "news" 
  List<News> _news = [];
  List<News> get getNews => _news;
  
  // To check the loading state
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // To check the "Try again" button state (pressed or not)
  bool _isPressed = false;
  bool get isPressed => _isPressed;

  @override
  void onInit() {
    super.onInit();
    // Call "fetchNews" function
    fetchNews();
  }

  // This function to get the news from "ApiProvider"
  Future<void> fetchNews() async {
    _isLoading = true;
    await ApiProvider.fetchNews()
      .then((news) {
        if (news.isNotEmpty) {
          _news = news;
        }
        _isLoading = false;
        _isPressed = false;
      })
      .catchError((error) {
        print('abd => getNews Error: $error');
        _isLoading = false;
        _isPressed = false;
      });
      update();
  }

  // This function to change the "Try again" button state
  void onPressed() {
    _isPressed = true;
    update();
  }

}