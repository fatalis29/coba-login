import 'package:flutter/material.dart';

class TextFieldCustomIcon extends StatelessWidget {
  final IconData icon;
  final Function(String) onChange;
  final String? hintText;

  const TextFieldCustomIcon({super.key, required this.icon, required this.onChange, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Icon(icon, color: Colors.grey, size: 16),
        ),
        Expanded(
          child: TextField(
            showCursor: true,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontSize: 16
            ),
            onChanged: onChange,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey)
            ),
          ),
          
        ),
      ],
    );
  }
}