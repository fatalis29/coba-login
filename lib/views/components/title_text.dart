import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

  TitleText({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        color: Colors.grey,
      ),
    );
  }
  
}