import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:kabakv1/services/auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              )),
          Divider(color: Colors.grey),
          //
          SizedBox(height: 20),
          //
          GoogleSignInButton(),
          //
          FacebookSignInButton(),
          //
          SizedBox(height: 20),
          //
          SignUpRichText(),
          //
          SizedBox(height: 60),
          //
          Divider(color: Colors.grey),
          //
          SingInRichText(),
        ],
      ),
    );
  }
}

class FacebookSignInButton extends StatelessWidget {
  const FacebookSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        Buttons.FacebookNew,
        onPressed: () {},
        text: 'Sign up with Facebook',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        Buttons.GoogleDark,
        onPressed: () {
          AuthService().signInWithGoogle();
        },
        text: 'Sign up with Google',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}

class SingInRichText extends StatelessWidget {
  const SingInRichText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an email account? ',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: 'Sign in.',
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/signin');
              },
          ),
        ],
      ),
    );
  }
}

class SignUpRichText extends StatelessWidget {
  const SignUpRichText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Or ',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        TextSpan(
          text: 'sign up',
          style: TextStyle(
              color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, '/registerWithEmail');
            },
        ),
        TextSpan(
          text: ' with email.',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
