import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/favorite_screen.dart';
import '../screens/search_screen.dart';
import '../screens/news_screen.dart';

class NavigationController extends GetxController {

  // Set "current screen" and "current screen index"
  int _currentScreenIndex = 2;
  Widget _currentScreen = FavoriteScreen();

  // Get "current screen" and "current screen index"
  Widget get currentScreen => _currentScreen;
  int get currentScreenIndex => _currentScreenIndex;

  // this function to change the current screen
  void changeScreen(int selectedScreen) {
    _currentScreenIndex = selectedScreen;
    switch (selectedScreen) {
      case 0:
        _currentScreen = NewsScreen();
        break;
      case 1:
        _currentScreen = SearchScreen();
        break;
      case 2:
        _currentScreen = FavoriteScreen();
        break;
    }
    update();
  }

}