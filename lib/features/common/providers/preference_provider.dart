import 'package:flutter/material.dart';
import 'package:template_flutter_provider/data/repositories/preference_repo.dart';

class PreferenceProvider with ChangeNotifier {
  final PreferencesRepository _repository;

  PreferenceProvider(this._repository);

  Locale _currentLocale = const Locale('en');
  Locale get currentLocale => _currentLocale;

  /// Initialize the locale from stored preferences
  Future<void> loadLanguage() async {
    String languageCode = await _repository.getUserLanguage();
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  /// Change the language and persist it
  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await _repository.saveUserLanguage(languageCode);
    notifyListeners();
  }
}
