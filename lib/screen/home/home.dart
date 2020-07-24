import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iot_kminh/model/language.dart';
import 'package:iot_kminh/utils/lang.dart';
import 'package:iot_kminh/utils/shared_prefs.dart';
import '../../main.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _changeLanguage(Language language) async {
    print('DEBUG: _changeLanguage ${language.languageCode}');
    Locale _locale = await setLocale(language.languageCode);
    JocoApp.setLocale(context, _locale);
  }

  void _initLanguage(String language) async {
    print('DEBUG: _changeLanguage $language');
    Locale _locale = await setLocale(language);
    JocoApp.setLocale(context, _locale);
  }

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text(translate(context, 'home_page')),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: _drawerList(),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _mainForm(context),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Text(
                translate(context, 'personal_information'),
                // DemoLocalization.of(context).translate('personal_information'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return translate(context, 'required_field');
                // return DemoLocalization.of(context).translate('required_fiedl');
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: translate(context, 'name'),
              hintText: translate(context, 'name_hint'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return translate(context, 'required_field');
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: translate(context, 'email'),
              hintText: translate(context, 'email_hint'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: translate(context, 'date_of_birth')),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year + 20),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                _showSuccessDialog();
              }
            },
            height: 50,
            shape: StadiumBorder(),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                translate(context, 'submit_info'),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 100,
              child: CircleAvatar(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              translate(context, 'about_us'),
              style: _textStyle,
            ),
            onTap: () {
              // To close the Drawer
              //Navigator.pop(context);
              // Navigating to About Page
              //Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              translate(context, 'settings'),
              style: _textStyle,
            ),
            onTap: () {
              // To close the Drawer
              //Navigator.pop(context);
              // Navigating to About Page
              //Navigator.pushNamed(context, settingsRoute);
            },
          ),
        ],
      ),
    );
  }
}