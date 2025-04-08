import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Store a key-value pair securely (email, token, etc.)
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve the value for a given key
  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Delete the stored data for a given key
  static Future<void> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Delete all the stored data
  static Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Save a boolean value
  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Retrieve the boolean value for a given key
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
