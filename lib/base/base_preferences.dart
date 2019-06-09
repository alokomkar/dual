import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static const String _SELECTED_LANGUAGE = "Selected_Language";
  SharedPreferences userPrefs;

  UserPreferences() {
    SharedPreferences.getInstance().then((preferences) {
      userPrefs = preferences;
    });
  }

  String getSelectedLanguage() => userPrefs.getString(_SELECTED_LANGUAGE) ?? "";

  void setSelectedLanguage( String language ) => userPrefs.setString(_SELECTED_LANGUAGE, language);

}

