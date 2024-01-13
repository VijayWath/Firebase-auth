import 'package:auth_app/services/firebase_auth_methods.dart';
import 'package:auth_app/widgets/custom_button.dart';
import 'package:auth_app/widgets/custom_textFeild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginEmailPasswordScreen extends StatefulWidget {
  static String routeName = '/login-email-password';
  const LoginEmailPasswordScreen({super.key});

  @override
  State<LoginEmailPasswordScreen> createState() =>
      _LoginEmailPasswordScreenState();
}

class _LoginEmailPasswordScreenState extends State<LoginEmailPasswordScreen> {
  final TextEditingController emailContrller = TextEditingController();
  final TextEditingController passwordContrller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailContrller.dispose();
    passwordContrller.dispose();
  }

  loginUser() {
    FirebaseAuthMethods(auth: FirebaseAuth.instance).signinWithEmail(
        email: emailContrller.text,
        password: passwordContrller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginEmailPasswordScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFeild(
              controller: emailContrller,
              hintText: 'enter Email',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFeild(
              controller: passwordContrller,
              hintText: 'enter Pssword',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            title: 'Login',
            onTap: loginUser,
          )
        ],
      ),
    );
  }
}
