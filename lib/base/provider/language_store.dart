import 'package:alpha_sample/models/internal/language.dart';
import 'package:alpha_sample/utils/shared_pref_utils.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  @observable
  String _locale = "vi";

  String get locale => _locale;

  _LanguageStore() {
    init();
  }

  Future init() async {
    _locale = await PrefUtils.currentLanguage ?? "vi";
  }

  List<Language> supportedLanguages = [
    Language(code: 'VN', locale: 'vi', language: 'Việt Nam'),
    Language(code: 'US', locale: 'en', language: 'English')
  ];

  String getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  String getCode() {
    var code;
    if (_locale == 'vi') {
      code = "VN";
    } else if (_locale == 'en') {
      code = "US";
    }
    return code;
  }

  @action
  Future<void> changeLanguage(String value) async {
    _locale = value;
    await PrefUtils.changeCurrentLanguage(_locale);
  }
}
