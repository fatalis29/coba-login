import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {

    @override
    TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

      if(newValue.selection.baseOffset == 0){
          return newValue;
      }

      double value = double.parse(newValue.text);

      final formatter = NumberFormat.simpleCurrency(locale: 'id', name: 'IDR', decimalDigits: 0);

      String newText = formatter.format(value).substring(2);

      return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length));
    }
}

class TextFieldRupiahFormat extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final String labelText;
  final Color borderColor;
  
  const TextFieldRupiahFormat({
    super.key, 
    this.validator, 
    this.onChange,
    this.labelText = 'Masukan Nominal',
    this.borderColor = const Color(0xFF4DD0E1),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Always visible "Rp" prefix
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Rp ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Text field without prefix
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  showCursor: true,
                  cursorColor: Colors.black, // Black cursor
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  validator: validator,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  onChanged: onChange,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    hintText: '0',
                    hintStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

