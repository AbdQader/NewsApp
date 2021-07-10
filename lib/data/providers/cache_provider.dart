import 'package:shared_preferences/shared_preferences.dart';
import '/core/utils/constants.dart';

class CacheProvider {

  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setDarkTheme(bool value) async {
    return await sharedPreferences.setBool(IS_DARK, value);
  }

  static Future<bool> getDarkTheme() async {
    return sharedPreferences.getBool(IS_DARK) ?? false;
  }

}