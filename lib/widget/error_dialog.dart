import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String errorMessage) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('error'),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
