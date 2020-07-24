import 'package:flutter/material.dart';
import 'package:iot_kminh/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization.dart';

const String LAGUAGE_CODE = 'languageCode';

const String VIETNAMESE = 'vi';
const String ENGLISH = 'en';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}


Locale _locale(String languageCode) {
  switch (languageCode) {
    case VIETNAMESE:
      return Locale(VIETNAMESE, 'VN');
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    default:
      return Locale(ENGLISH, 'US');
  }
}

String translate(BuildContext context, String key) {
  return AppLocalization.of(context).translate(key);
}
