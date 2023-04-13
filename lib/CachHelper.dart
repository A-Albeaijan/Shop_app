import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedpreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedpreferences!.setInt(key, value);
    } else if (value is bool) {
      return await sharedpreferences!.setBool(key, value);
    } else {
      return await sharedpreferences!.setDouble(key, value);
    }
  }

  static dynamic getData(String key) {
    return sharedpreferences!.get(key);
  }

  static Future<bool> removeData(String key) async {
    return await sharedpreferences!.remove(key);
  }
}
