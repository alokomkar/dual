import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static const String _SELECTED_LANGUAGE = "Selected_Language";

  UserPreferences() {
    init();
  }

  SharedPreferences userPrefs;

  void init() async {
    userPrefs = await SharedPreferences.getInstance();
  }

  String getSelectedLanguage() => userPrefs.getString(_SELECTED_LANGUAGE) ?? "";

  void setSelectedLanguage( String language ) => userPrefs.setString(_SELECTED_LANGUAGE, language);

}

