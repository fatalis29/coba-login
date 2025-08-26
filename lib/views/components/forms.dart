import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldItem extends StatefulWidget {
  final String fieldTitle;
  final TextInputType inputType;
  final int maxLength;
  final String? hintText;
  final String? validationText;
  final bool isObscured;
  final Widget? suffixIcon;
  final bool enabled;
  final Function(String val)? onChanged;
  final String? counterText;
  final bool visibleCounter;

  const FormFieldItem({
    Key? key,
    required this.fieldTitle,
    this.inputType = TextInputType.text,
    this.maxLength = 40,
    this.hintText,
    this.validationText,
    this.isObscured = false,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
    this.counterText,
    this.visibleCounter = false,
  }) : super(key: key);

  @override
  State<FormFieldItem> createState() => _FormFieldItemState();
}

class _FormFieldItemState extends State<FormFieldItem> {
  bool _isEmpty = true;

  void _handleTextChange(String value) {
    setState(() {
      _isEmpty = value.isEmpty;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: Text(
            widget.fieldTitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: TextFormField(
            keyboardType: widget.inputType,
            enabled: widget.enabled,
            maxLength: widget.maxLength,
            obscureText: widget.isObscured,
            onChanged: _handleTextChange,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
              suffixIcon: widget.suffixIcon != null 
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: widget.suffixIcon,
                  )
                : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              counterText: '',
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            )
          ),
        ),
        if (_isEmpty && widget.validationText != null)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
            child: Text(
              widget.validationText!,
              style: TextStyle(
                color: Colors.teal[700],
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class StyledFormFieldItem extends StatelessWidget {
  final TextInputType inputType;
  final int maxLength;
  final String? hintText;
  final bool isObscured;
  final Widget? suffixIcon;
  final bool enabled;
  final Function(String val)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const StyledFormFieldItem({
    Key? key,
    this.inputType = TextInputType.text,
    this.maxLength = 40,
    this.hintText,
    this.isObscured = false,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add some vertical spacing between fields
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        enabled: enabled,
        maxLength: maxLength,
        obscureText: isObscured,
        obscuringCharacter: "*",
        onChanged: onChanged,
        validator: validator,
        cursorColor: const Color(0xFF008B8B), // Add cursor color here
        decoration: InputDecoration(
          // The hintText now serves as the primary label inside the field.
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.normal,
          ),
          // Use OutlineInputBorder for a modern, bordered look.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Color(0xFF008B8B), // Highlight with primary color on focus
              width: 1.5,
            ),
          ),
          // Fill color for the text field's interior
          fillColor: Colors.white,
          filled: true,
          // Suffix icon for visibility toggle, etc.
          suffixIcon: suffixIcon,
          // Remove the default counter text to avoid clutter.
          counterText: '',
          // Adjust content padding for a better visual balance.
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}