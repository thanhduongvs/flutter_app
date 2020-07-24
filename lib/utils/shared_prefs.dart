import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  SharedPrefs._internal();

  static SharedPreferences _prefs;

  static const String _isLogin = "is_login";
  static const String _isFirst = "is_first";
  static const String _authToken = "auth_token";
  static const String _password = "password";
  static const String _language = "language";

  static Future<SharedPreferences> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static SharedPreferences self() {
    return _prefs;
  }

  Future<void> clearData() async {
    _prefs.clear();
  }

  Future<void> removeKey(String key) async {
    _prefs.remove(key);
  }

  Future<bool> checkIfKeyExists(String key) async {
    return _prefs.containsKey(key);
  }

  static Future<void> notFirst() async {
    _prefs.setBool(_isFirst, true);
  }
  static bool isFirst() {
    return _prefs.getBool(_isFirst) ?? false;
  }
  /// login
  static Future<void> login() async {
    _prefs.setBool(_isLogin, true);
  }
  static Future<void> logout() async {
    _prefs.setBool(_isLogin, false);
  }
  static bool isLogin() {
    return _prefs.getBool(_isLogin) ?? false;
  }

  /// language
  static Future<void> setLanguage(String lang) async {
    _prefs.setString(_language, lang);
  }
  static String getLanguage() {
    return _prefs.getString(_language) ?? null;
  }

  /// auth token
  static Future<void> setAuthToken(String authToken) async {
    _prefs.setString(_authToken, authToken);
  }
  static String getAuthToken() {
    return _prefs.getString(_authToken) ?? null;
  }

  /// password
  static Future<void> setPassword(String password) async {
    _prefs.setString(_password, password);
  }
  static String getPassword() {
    return _prefs.getString(_password) ?? null;
  }
}
