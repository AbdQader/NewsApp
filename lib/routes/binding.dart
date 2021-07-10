import 'package:get/get.dart';
import '/data/controllers/news_controller.dart';
import '/data/controllers/search_controller.dart';
import '/data/controllers/favorite_controller.dart';
import '/data/controllers/navigation_controller.dart';
import '/data/controllers/theme_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
