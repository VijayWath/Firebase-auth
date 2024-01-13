import 'package:flutter/material.dart';

void showOTPDailog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onpressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog.adaptive(
      title: const Text("Enter OPT"),
      content: Column(
        children: [
          TextField(
            controller: codeController,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: onpressed,
          child: const Text("Done"),
        ),
      ],
    ),
  );
}
