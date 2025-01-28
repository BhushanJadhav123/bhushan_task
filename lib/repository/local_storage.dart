import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  static void saveTheme(bool isDarkTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkTheme", isDarkTheme);
  }

  static Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    return isDarkTheme;
  }
}
