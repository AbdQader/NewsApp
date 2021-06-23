import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controllers/theme_controller.dart';
import './controllers/navigation_controller.dart';
import './core/themes/app_theme.dart';
import './helpers/binding.dart';

void main() async {
  // Make sure that the code below is executed before "runApp"
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put(ThemeController()).getThemeMode();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        themeMode: Get.put(ThemeController()).themeMode.value,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controller = Get.put(ThemeController());
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
              color: Theme.of(context).buttonColor,
            ),
          ),
          ),
        ],
      ),
      body: GetBuilder<NavigationController>(
        init: NavigationController(),
        builder: (controller) => controller.currentScreen,
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.currentScreenIndex,
        unselectedItemColor: Theme.of(context).primaryColor,
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
