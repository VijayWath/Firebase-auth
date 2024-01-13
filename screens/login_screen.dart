import 'package:auth_app/screens/login_email_password_screen.dart';
import 'package:auth_app/screens/phone_screen.dart';
import 'package:auth_app/screens/signup_email_password_screen.dart';
import 'package:auth_app/services/firebase_auth_methods.dart';
import 'package:auth_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              title: 'Email/password Signup',
              onTap: () {
                Navigator.pushNamed(
                    context, SignupEmailPasswordScreen.routeName);
              },
            ),
            CustomButton(
              title: 'Email/password Login',
              onTap: () {
                Navigator.pushNamed(
                    context, LoginEmailPasswordScreen.routeName);
              },
            ),
            CustomButton(
              title: 'Phone Signin',
              onTap: () {
                Navigator.pushNamed(context, PhoneScreen.routeName);
              },
            ),
            CustomButton(
              title: 'Google Signin',
              onTap: () {
                FirebaseAuthMethods(auth: FirebaseAuth.instance)
                    .googleSigin(context);
              },
            ),
            CustomButton(
              title: 'Facebook Signin',
              onTap: () {},
            ),
            CustomButton(
              title: 'Anonymous Signin',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
