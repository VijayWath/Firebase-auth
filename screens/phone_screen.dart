import 'package:auth_app/services/firebase_auth_methods.dart';
import 'package:auth_app/widgets/custom_button.dart';
import 'package:auth_app/widgets/custom_textFeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone-screen';
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
  }

  Future<void> signinWithPhone() async {
    FirebaseAuthMethods(auth: FirebaseAuth.instance).signinWithPhone(
        context: context, number: phoneNumberController.text.trim());
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
            'Phone Login',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextFeild(
              controller: phoneNumberController,
              hintText: 'enter phone number',
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            title: 'send OTP',
            onTap: signinWithPhone,
          )
        ],
      ),
    );
  }
}
