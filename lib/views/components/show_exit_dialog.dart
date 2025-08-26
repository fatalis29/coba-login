import 'package:flutter/material.dart';

void showExitDialog(BuildContext context, /** navigator */) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: const Text('Keluar Aplikasi'),
        content: const Text('Apakah anda ingin keluar dari Aplikasi?'),
        actions: [
          TextButton(
            child: const Text('Tidak'),
            onPressed:() {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ya'),
            onPressed:() {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      );
    }
  );
}