import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iot_kminh/network/base_service.dart';
import 'package:iot_kminh/screen/routes.dart';
import 'package:iot_kminh/screen/signin/signin_view.dart';
import 'package:iot_kminh/screen/splash/splash_screen.dart';
import 'network/repository.dart';
import 'page/post/post_bloc.dart';
import 'screen/home/home.dart';
import 'screen/onboarding/onboarding_bloc.dart';
import 'screen/onboarding/onboarding_view.dart';
import 'screen/signin/signin_bloc.dart';
import 'screen/signup/signup_bloc.dart';
import 'screen/signup/signup_view.dart';
import 'utils/lang.dart';
import 'utils/localization.dart';
import 'utils/shared_prefs.dart';

void main() {
  final Repository repository = Repository(
    service: BaseService(),
  );
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OnboardingBloc(),),
            BlocProvider(create: (context) => SignInBloc(),),
            BlocProvider(create: (context) => SignUpBloc(),),
            BlocProvider(create: (context) => PostBloc(repository: repository),),
          ],
          child: JocoApp()
      )
  );
}

class JocoApp extends StatefulWidget {
  const JocoApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _JocoAppState state = context.findAncestorStateOfType<_JocoAppState>();
    state.setLocale(newLocale);
  }
  @override
  _JocoAppState createState() => _JocoAppState();
}

class _JocoAppState extends State<JocoApp> {

  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SharedPrefs.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [
        Locale("vi", "VN"),
        Locale("en", "US")
      ],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        Routes.onBoarding: (context) => OnboardingScreen(),
        Routes.signIn: (context) => SignInScreen(),
        Routes.signUp: (context) => SignUpScreen(),
        Routes.home: (context) => HomeScreen(),
        //Routes.favourites: (context) => FavouritesScreen()
      },
    );
  }
}

