import 'dart:convert';

import 'package:alpha_sample/models/internal/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static final String keyFcmToken = "KEY_FCM_TOKEN";
  static final String devicesId = "KEY_DEVICES_ID";
  static final String keyIsDarkMode = "KEY_IS_DARK_MODE";
  static final String keyCurrentLanguage = "KEY_CURRENT_LANGUAGE";
  static final String keyConfig = "KEY_CONFIG";

  static Future<void> setFcmToken({String fcmToken}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyFcmToken, fcmToken);
  }

  static Future<String> getFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyFcmToken) ?? null;
  }

  static Future<void> changeBrightnessToDark(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyIsDarkMode, value);
  }

  static Future<bool> get isDarkMode async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsDarkMode) ?? false;
  }

  static Future<void> changeCurrentLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyCurrentLanguage, language);
  }

  static Future<String> get currentLanguage async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyCurrentLanguage) ?? "vi";
  }

  static Future<void> setConfigItem({Config config}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyConfig, jsonEncode(config.toJson()));
  }

  static Future<Config> get getConfig async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(keyConfig);
    if (data == null) return null;
    Config config = Config.fromJson(json.decode(data));
    return config;
  }

  static Future<bool> setDevicesId({String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(devicesId, value);
  }

  static Future<String> getDevicesId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(devicesId) == null) return null;
    var _devicesId = prefs.getString(devicesId);
    return _devicesId;
  }

  static Future<Null> clear() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      for (String key in prefs.getKeys()) {
        print('Logout app - remove key $key');
        await prefs.remove(key);
      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }
}
