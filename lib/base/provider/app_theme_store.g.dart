// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppThemeStore on _AppThemeStore, Store {
  final _$_darkModeAtom = Atom(name: '_AppThemeStore._darkMode');

  @override
  bool get _darkMode {
    _$_darkModeAtom.reportRead();
    return super._darkMode;
  }

  @override
  set _darkMode(bool value) {
    _$_darkModeAtom.reportWrite(value, super._darkMode, () {
      super._darkMode = value;
    });
  }

  final _$changeBrightnessToDarkAsyncAction =
      AsyncAction('_AppThemeStore.changeBrightnessToDark');

  @override
  Future<void> changeBrightnessToDark(bool value) {
    return _$changeBrightnessToDarkAsyncAction
        .run(() => super.changeBrightnessToDark(value));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
