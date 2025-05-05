import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_provider/core/constants/shared_prefs_name.dart';

class PreferenceService {
  final Future<SharedPreferences> _sharedPrefs = SharedPreferences.getInstance();

  PreferenceService();

  Future<void> setLanguage(String language) async {
    final prefs = await _sharedPrefs;
    await prefs.setString(SharedPrefsName.language, language);
  }

  Future<String?> getLanguage() async {
    final prefs = await _sharedPrefs;
    return prefs.getString(SharedPrefsName.language);
  }
}
