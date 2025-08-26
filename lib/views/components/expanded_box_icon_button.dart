
import 'package:flutter/material.dart';

enum ButtonFillType {
  elevated,
  filled
}

class ExpandedBoxIconButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final IconData iconButton;
  final double height;
  final ButtonFillType buttonType;

  const ExpandedBoxIconButton({super.key, 
    required this.onPressed,
    required this.text,
    required this.iconButton,
    this.height = 120,
    this.buttonType = ButtonFillType.elevated,
  });

  @override
  Widget build(BuildContext context) {
    return buttonType == ButtonFillType.filled ?
    FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height
        ),
        child: Center(
          child: Column(
            children: [
              Icon(iconButton, size: 32),
              const SizedBox(height: 8, width: 8),
              Text(text)
            ],
          ),
        ),
      )
    ) :
    ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height
        ),
        child: Center(
          child: Column(
            children: [
              Icon(iconButton, size: 32),
              const SizedBox(height: 8, width: 8),
              Text(text)
            ],
          ),
        ),
      )
    );
  }

}