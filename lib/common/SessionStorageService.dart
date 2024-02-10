import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageService {
  static SessionStorageService? manager;
  static SharedPreferences? prefs;
  static const String PAIR_ANSWER = "PAIR_ANSWER";
  static const String CATEGORY_GROUP_INDEX = "CATEGORY_GROUP_INDEX";

  static Future<SessionStorageService?> getInstance() async {
    if (manager == null || prefs == null) {
      manager = SessionStorageService();
      prefs = await SharedPreferences.getInstance();
    }
    return manager;
  }

  void savePairAnswer(bool answer) {
    prefs?.setBool(PAIR_ANSWER, answer);
  }

  void saveCategoryGroupIndex(int group) {
    prefs?.setInt(CATEGORY_GROUP_INDEX, group);
  }

  bool? retrieveCity() {
    return prefs?.getBool(PAIR_ANSWER);
  }

  int? retrieveCategoryGroupIndex() {
    return prefs?.getInt(CATEGORY_GROUP_INDEX);
  }
}