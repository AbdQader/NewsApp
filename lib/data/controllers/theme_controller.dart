import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/data/providers/cache_provider.dart';

class ThemeController extends GetxController {

  // To Set ThemeMode & Get Theme Mode
  Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  Rx<ThemeMode> get themeMode => _themeMode;

  @override 
  void onInit() {
    super.onInit();
    // Call "getThemeMode" function
    getThemeMode();
  }

  // This function to get theme mode from "SharedPreferences"
  Future<void> getThemeMode() async {
    bool isDark = await CacheProvider.getDarkTheme();
    if (isDark)
      _themeMode.value = ThemeMode.dark;
    else
      _themeMode.value = ThemeMode.light;
  }

  // This function to change theme mode "dark or light"
  Future<void> changeThemeMode() async {
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
      CacheProvider.setDarkTheme(true);
    } else {
      _themeMode.value = ThemeMode.light;
      CacheProvider.setDarkTheme(false);
    }
  }

}