import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/controllers/navigation_controller.dart';
import '/data/controllers/theme_controller.dart';
import '/data/controllers/news_controller.dart';
import '/data/controllers/search_controller.dart';
import '/data/controllers/favorite_controller.dart';
import '/data/providers/cache_provider.dart';
import '/core/themes/theme.dart';
import '/routes/binding.dart';

void main() async {
  // Make sure that the code below is executed before "runApp"
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Shared Preferences
  await CacheProvider.init();
  // Initialize Controllers
  Get.put(NavigationController());
  Get.put(ThemeController());
  Get.put(NewsController());
  Get.put(SearchController());
  Get.put(FavoriteController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: Get.find<ThemeController>().themeMode.value,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialBinding: AppBinding(),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controller = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          Obx(() => IconButton(
              onPressed: () => controller.changeThemeMode(),
              icon: Icon(
                controller.themeMode.value == ThemeMode.dark
                ? Icons.brightness_2
                : Icons.wb_sunny,
                color: Get.theme.buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<NavigationController>(
        builder: (controller) => controller.currentScreen,
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<NavigationController>(
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.currentScreenIndex,
        unselectedItemColor: Get.theme.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        onTap: (value) => controller.changeScreen(value),
      ),
    );
  }

}
