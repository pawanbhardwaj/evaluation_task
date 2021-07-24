import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String USER_ID = 'user-id';
  static const String USER_NAME = 'user-name';
  static SharedPreferences? preferences;

  static Future<SharedPreferences> init() async {
    preferences = await SharedPreferences.getInstance();
    return preferences!;
  }

  ///Method that saves the [User Id].
  static Future<bool> setUserId(String value) async =>
      preferences!.setString(USER_ID, value);

  ///Method that returns the [User Id].
  static String getUserId() => preferences!.getString(USER_ID) ?? '';

  ///Method that saves the [User NAME].
  static Future<bool> setUserName(String value) async =>
      preferences!.setString(USER_NAME, value);

  ///Method that returns the [User Name].
  static String getUserName() => preferences!.getString(USER_NAME) ?? '';

  static Future<bool> clear() async => await preferences!.clear();
}
