import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget{
  final String linkText;
  final Function()? onPressed;

  ClickableText({
    required this.linkText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: linkText,
          style: TextStyle(
            color: Colors.teal[700],
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = onPressed)
      ),
    );
  }
}