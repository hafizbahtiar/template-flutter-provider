import '../services/preference_service.dart';

class PreferencesRepository {
  final PreferenceService _service;

  PreferencesRepository(this._service);

  Future<void> saveUserLanguage(String languageCode) async {
    await _service.setLanguage(languageCode);
  }

  Future<String> getUserLanguage() async {
    return await _service.getLanguage() ?? 'en';
  }
}
