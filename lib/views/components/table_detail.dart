import 'package:flutter/material.dart';

class TableRowDetail extends TableRow {
  final String rowTitle;
  final String? rowContent;
  final TextStyle? customStyle;

  TableRowDetail({required this.rowTitle, this.rowContent, this.customStyle});

  @override
  List<Widget> get children {
    // Style for the title: Gray if it's a label, bold if it's a section header.
    final titleStyle = rowContent != null
        ? TextStyle(color: Colors.grey.shade700, fontSize: 14)
        : TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5);

    // Default style for the content, which can be overridden by customStyle.
    final contentStyle = const TextStyle(
      fontWeight: FontWeight.w600, // A medium bold weight
      fontSize: 14,
    ).merge(customStyle); // Merge allows customStyle to override defaults.

    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Text(rowTitle, style: titleStyle),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: rowContent != null
            ? Text(
                rowContent!,
                style: contentStyle,
                textAlign: TextAlign.right, // Align content to the right
              )
            : const SizedBox(),
      ),
    ];
  }
}

class TableRowSpacer extends TableRow {
  @override
  List<Widget> get children {
    return [
      SizedBox(height: 16),
      SizedBox(height: 16)
    ];
  }
}