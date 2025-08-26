import 'package:dbank/models/ui_model_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  // Transaction data
  double _transactionAmount = 10000;
  String? _qrUrl;
  String _merchantName = 'Nama merchant biasa'; // TODO: get from session
  String _merchantId = '1234567890'; // TODO: get from session

  double get transactionAmount => _transactionAmount;
  String? get qrUrl => _qrUrl;
  String get merchantName => _merchantName;
  String get merchantId => _merchantId;

  TransactionViewModel();

  // Functions

  String formatAmountToRupiah(double amount) {
    return NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(amount);
  }
}