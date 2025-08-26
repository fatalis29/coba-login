import 'package:flutter/material.dart';

void showCustomDialog(
  BuildContext context,
  String title,
  String message,
  List<Map<String, Function()>> listOfActions) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: [
          ...listOfActions.map((action) {
            final String actionText = action.keys.first;
            return TextButton(
              onPressed: action[actionText],
              child: Text(actionText),
            );
          })
        ],
      );
    }
  );
}