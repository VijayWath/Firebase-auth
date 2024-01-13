import 'package:auth_app/services/firebase_auth_methods.dart';
import 'package:auth_app/widgets/custom_button.dart';
import 'package:auth_app/widgets/custom_textFeild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupEmailPasswordScreen extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const SignupEmailPasswordScreen({super.key});

  @override
  State<SignupEmailPasswordScreen> createState() =>
      _SignupEmailPasswordScreenState();
}

class _SignupEmailPasswordScreenState extends State<SignupEmailPasswordScreen> {
  final TextEditingController emailContrller = TextEditingController();
  final TextEditingController passwordContrller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailContrller.dispose();
    passwordContrller.dispose();
  }

  void signUpUser() async {
    FirebaseAuthMethods(auth: FirebaseAuth.instance).signupWithEmail(
        email: emailContrller.text,
        password: passwordContrller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignupEmailPasswordScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Signup',
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
            title: 'Sign up',
            onTap: signUpUser,
          )
        ],
      ),
    );
  }
}
