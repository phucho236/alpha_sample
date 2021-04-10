import 'package:alpha_sample/utils/shared_pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_theme_store.g.dart';

class AppThemeStore = _AppThemeStore with _$AppThemeStore;

abstract class _AppThemeStore with Store {
  @observable
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  _AppThemeStore() {
    init();
  }

  Future init() async {
    _darkMode = await PrefUtils.isDarkMode ?? false;
  }

  @action
  Future<void> changeBrightnessToDark(bool value) async {
    _darkMode = value;
    await PrefUtils.changeBrightnessToDark(_darkMode);
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;
}
