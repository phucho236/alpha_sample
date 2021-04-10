// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LanguageStore on _LanguageStore, Store {
  final _$_localeAtom = Atom(name: '_LanguageStore._locale');

  @override
  String get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(String value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  final _$changeLanguageAsyncAction =
      AsyncAction('_LanguageStore.changeLanguage');

  @override
  Future<void> changeLanguage(String value) {
    return _$changeLanguageAsyncAction.run(() => super.changeLanguage(value));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
