import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefference {
  static SharedPreferences? _preferences;

  static const String keyUserType = 'usertype';
  static const String keyIsLogin = 'isLogin';
  static const String keyUserId = 'userId';

  static Future<SharedPreferences> getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future saveUserType(String type) async {
    return await _preferences!.setString(keyUserType, type);
  }

  static String getUserType() {
    return _preferences?.getString(keyUserType) ?? "";
  }

  static Future saveIsLogin(bool value) async {
    return await _preferences!.setBool(keyIsLogin, value);
  }

  static bool getIsLogin() {
    return _preferences?.getBool(keyIsLogin) ?? false;
  }

  static Future<void> saveUserId(String id) async {
    await _preferences?.setString(keyUserId, id);
  }

  static String? getUserId() {
    return _preferences?.getString(keyUserId);
  }

  static Future clearPrefs() async {
    final pref = _preferences ?? await SharedPreferences.getInstance();
    await pref.clear();
  }
}
