import 'package:get/get.dart';
import 'package:news_app/main.dart';
import '/views/screens/favorite_screen.dart';
import '/views/screens/news_screen.dart';
import '/views/screens/search_screen.dart';
import 'routes.dart';

class AppPages {

  static final routes = [
    GetPage(
      name: AppRoutes.HOME, 
      page: () => MyHomePage(),
      // bindings: [
      //   NavigationBinding(),
      //   ThemeBinding(),
      // ]
    ),
    GetPage(
      name: AppRoutes.NEWS, 
      page: () => NewsScreen(),
      //binding: NewsBinding(),
    ),
    GetPage(
      name: AppRoutes.SEARCH, 
      page: () => SearchScreen(),
      //binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes.FAVORITE,
      page: () => FavoriteScreen(),
      //binding: FavoriteBinding(),
    )
  ];

}