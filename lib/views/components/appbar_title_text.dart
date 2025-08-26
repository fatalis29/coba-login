import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget{
  final String title;
  const AppBarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}