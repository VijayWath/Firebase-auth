import 'package:auth_app/utils/otpDailogBox.dart';
import 'package:auth_app/utils/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods({required FirebaseAuth auth}) : _auth = auth;
  //Email-password signup
  Future<void> signupWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Email login
  Future<void> signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Email Verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'email verification has been sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Phone Sign in
  Future<void> signinWithPhone({
    required String number,
    required BuildContext context,
  }) async {
    TextEditingController codeController = TextEditingController();

    try {
      //web
      if (kIsWeb) {
        ConfirmationResult result = await _auth.signInWithPhoneNumber(number);
        showOTPDailog(
          context: context,
          codeController: codeController,
          onpressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: result.verificationId,
              smsCode: codeController.text.trim(),
            );
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop();
          },
        );
      } else {
        // Android and ios
        await _auth.verifyPhoneNumber(
          codeAutoRetrievalTimeout: (verificationId) {},
          phoneNumber: number,
          verificationCompleted: (PhoneAuthCredential credentials) async {
            await _auth.signInWithCredential(credentials);
          },
          verificationFailed: (error) {
            showSnackBar(context, error.message!);
          },
          codeSent: ((String verificationId, int? forceResendingToken) async {
            showOTPDailog(
              context: context,
              codeController: codeController,
              onpressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim(),
                );
                await _auth.signInWithCredential(credential);
                Navigator.of(context).pop();
              },
            );
          }),
        );
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // google sign In
  Future<void> googleSigin(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        googleAuthProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _auth.signInWithPopup(googleAuthProvider);
      }
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null) {
        final credential = await GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print(e);
      showSnackBar(context, 'somethong went wrong');
    }
  }
}
