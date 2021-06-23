import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {

  Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  String? _themeModeText;

  // Get Theme Mode
  Rx<ThemeMode> get themeMode => _themeMode;

  // This function to get theme mode from "SharedPreferences"
  Future<void> getThemeMode() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _themeModeText = sp.getString('theme') ?? 'light';
    if (_themeModeText == 'light')
      _themeMode.value = ThemeMode.light;
    else
      _themeMode.value = ThemeMode.dark;
  }

  // This function to change theme mode "dark or light"
  Future<void> changeThemeMode() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
      _themeModeText = 'dark';
      sp.setString('theme', _themeModeText!);
    } else {
      _themeMode.value = ThemeMode.light;
      _themeModeText = 'light';
      sp.setString('theme', _themeModeText!);
    }
  }

}