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

class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SignInForm(),
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Scaffold.of(context).hideCurrentSnackBar();
          showDialog(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        }
        if (state.status.isSubmissionInProgress) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(Dimens.medium),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
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
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            EmailInput(),
            PasswordInput(),
            SubmitButton(),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: Strings.email,
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.bloc<SignInBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isShowPassWord = false;
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid Password' : null,
              suffixIcon: IconButton(
                icon: Icon(
                  _isShowPassWord
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  _isShowPassWord = !_isShowPassWord;
                })
          ),
          obscureText: !_isShowPassWord,
          onChanged: (value) {
            context.bloc<SignInBloc>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }

}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RaisedButton(
          onPressed: state.status.isValidated
              ? () => context.bloc<SignInBloc>().add(FormSubmitted())
              : null,
          child: Text(translate(context, Strings.signIn)),
        );
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

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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