import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_kminh/resources/dimens.dart';
import 'package:iot_kminh/resources/strings.dart';
import 'package:iot_kminh/resources/styles.dart';
import 'package:iot_kminh/utils/lang.dart';
import '../routes.dart';
import 'signin_bloc.dart';
import 'signin_event.dart';
import 'signin_state.dart';
import 'package:formz/formz.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isShowPassWord = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          print('DEBUG: isSubmissionSuccess');
          _scaffoldKey.currentState.hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        }
        if (state.status.isSubmissionInProgress) {
          print('DEBUG: isSubmissionInProgress');
          _scaffoldKey.currentState.hideCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Submitting...')
          ));
        }
      },
      builder: (context, state){
        return Scaffold(
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.all(Dimens.medium),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Container(
                  child: Center(
                    child: FlutterLogo(
                      size: 64,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.medium,
                  width: double.infinity,
                ),
                emailInput(context, state),
                passwordInput(context, state),
                buttonSignIn(context, state),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                gotoSignUp(context),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

  Widget emailInput(BuildContext context, SignInState state){
    return TextFormField(
      initialValue: state.email.value,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: Strings.email,
        errorText: state.email.invalid ? translate(context, Strings.invalidEmail) : null,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.bloc<SignInBloc>().add(EmailChanged(email: value));
      },
    );
  }

  Widget passwordInput(BuildContext context, SignInState state){
    return TextFormField(
      initialValue: state.password.value,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: translate(context, Strings.password),
          errorText: state.password.invalid ? translate(context, Strings.invalidPassword) : null,
          suffixIcon: IconButton(
              icon: Icon(
                _isShowPassWord
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: showPassWord
          )
      ),
      obscureText: !_isShowPassWord,
      onChanged: (value) {
        context.bloc<SignInBloc>().add(PasswordChanged(password: value));
      },
    );
  }

  Widget buttonSignIn(BuildContext context, SignInState state){
    return RaisedButton(
      onPressed: state.status.isValidated
          ? () => context.bloc<SignInBloc>().add(FormSubmitted())
          : null,
      child: Text(translate(context, Strings.signIn)),
    );
  }

  Widget gotoSignUp(BuildContext context){
    return FlatButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(translate(context, Strings.notAccount)),
          Text(
            translate(context, Strings.signUp),
            style: textBlue,
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.signUp);
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}