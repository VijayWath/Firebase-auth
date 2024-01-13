import 'package:auth_app/firebase_options.dart';
import 'package:auth_app/screens/login_email_password_screen.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'package:auth_app/screens/phone_screen.dart';
import 'package:auth_app/screens/signup_email_password_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 131, 183, 58),
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      routes: {
        SignupEmailPasswordScreen.routeName: (context) =>
            const SignupEmailPasswordScreen(),
        LoginEmailPasswordScreen.routeName: (context) =>
            const LoginEmailPasswordScreen(),
        PhoneScreen.routeName: (context) => const PhoneScreen()
      },
    );
  }
}
