import 'dart:convert';

import 'package:alpha_sample/models/internal/config.dart';
import 'package:alpha_sample/utils/shared_pref_utils.dart';
import 'package:flutter/services.dart' show rootBundle;

class ConfigService {
  Future loadConfig;
  Config config;

  factory ConfigService() => ConfigService._();

  ConfigService._() {
    loadConfig = Future(() async {
      config = await PrefUtils.getConfig;
      if (config == null) {
        String data = await rootBundle.loadString('assets/app_config.json');
        setConfig(Config.fromJson(json.decode(data)));
      }
    });
  }

  Future<void> setConfig(Config value) async {
    config = value;
    await PrefUtils.setConfigItem(config: config);
  }

  /// screens
  ScreenItem get loginScreen => config.screens[
      config.screens.indexWhere((item) => item.name == 'login_screen')];

  /// features
  FeatureItem get localNotification => config.features[
      config.features.indexWhere((item) => item.name == 'local_notification')];

  FeatureItem get darkMode => config
      .features[config.features.indexWhere((item) => item.name == 'dark_mode')];

  FeatureItem get multiLanguage => config.features[
      config.features.indexWhere((item) => item.name == 'multi_language')];

  FeatureItem get fcmNotification => config.features[
      config.features.indexWhere((item) => item.name == 'fcm_notification')];

  FeatureItem get qrCode =>
      config.features[config.features.indexWhere((item) => item.name == 'qr_code')];

  FeatureItem get viewImage => config.features[
      config.features.indexWhere((item) => item.name == 'view_image')];

  FeatureItem get ads => config.features[
      config.features.indexWhere((item) => item.name == 'ads')];
}
