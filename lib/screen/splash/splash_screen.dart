import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_kminh/resources/images.dart';
import 'package:iot_kminh/utils/lang.dart';
import 'package:iot_kminh/utils/shared_prefs.dart';
import '../../main.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget{

  SplashScreen({Key key}) : super(key: key);

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {

  double screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    // Hide Statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // Transparant Statusbar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // Show Statusbar
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    _loadSettings();
  }

  void _loadSettings() async {
    Future.delayed(Duration(seconds: 1), () {
      //Route route = MaterialPageRoute(builder: (context) => OnBoardingScreen());
      //Navigator.pushReplacement(context, route);

      if(SharedPrefs.isFirst() == false){
        SharedPrefs.notFirst();
        Navigator.of(context).pushNamed(Routes.onBoarding);
      } else {
        Navigator.of(context).pushNamed(Routes.onBoarding);
      }
    });
  }

  void _initLanguage(String language) async {
    print('DEBUG: _changeLanguage $language');
    Locale _locale = await setLocale(language);
    JocoApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    bool first = SharedPrefs.isFirst();
    if(first == false){
      String languageCode = Platform.localeName.split('_')[0];
      if(languageCode == 'vi'){
        _initLanguage('vi');
      } else {
        _initLanguage('en');
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]),
          )
        ),
      ),
    );
  }
}