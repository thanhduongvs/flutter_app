import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_kminh/resources/dimens.dart';
import 'package:iot_kminh/resources/strings.dart';
import 'package:iot_kminh/resources/styles.dart';
import 'package:iot_kminh/utils/lang.dart';
import '../routes.dart';
import 'package:formz/formz.dart';
import 'signup_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isShowPassWord = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.medium),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - Dimens.medium),
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
                  repeatPasswordInput(context, state),
                  registerButton(context, state),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  gotoSignIn(context),
                ],
              ),
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

  Widget emailInput(BuildContext context, SignUpState state){
    return TextFormField(
      initialValue: state.email.value,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: Strings.email,
        errorText: state.email.invalid ? translate(context, Strings.invalidEmail) : null,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.bloc<SignUpBloc>().add(EmailChanged(email: value));
      },
    );
  }

  Widget passwordInput(BuildContext context, SignUpState state){
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
        context.bloc<SignUpBloc>().add(PasswordChanged(password: value));
      },
    );
  }

  Widget repeatPasswordInput(BuildContext context, SignUpState state){
    return TextFormField(
      initialValue: state.password.value,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          labelText: translate(context, Strings.repeatPassword),
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
        context.bloc<SignUpBloc>().add(PasswordChanged(password: value));
      },
    );
  }

  Widget registerButton(BuildContext context, SignUpState state){
    return RaisedButton(
      onPressed: state.status.isValidated
        ? () => context.bloc<SignUpBloc>().add(FormSubmitted())
        : null,
      child: Text(translate(context, Strings.signIn)),
    );
  }

  Widget gotoSignIn(BuildContext context){
    return FlatButton(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(translate(context, Strings.haveAccount)),
          Text(
            translate(context, Strings.signIn),
            style: textBlue,
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.signIn);
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