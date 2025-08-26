import 'package:dbank/utilities/utilities.dart';
import 'package:flutter/material.dart';

enum DashboardModelStatus {
  Ended,
  Loading,
  Error,
}

class DashboardViewModel extends ChangeNotifier{
  // UI States
  DashboardModelStatus _status = DashboardModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  DashboardModelStatus get status => _status;


  // Dashboard data
  late String _name = '';
  late String _dateTime = DateTime.now().toString();
  late double _totalTransaction = 0;

  String get name => _name;
  String get dateTime => _dateTime.toString();
  double get totalTransaction => _totalTransaction;

  DashboardViewModel() {
    getDateTime();
    _name = 'Merchant Name'; // Placeholder for merchant name
  }

  // Functions
  void getDateTime() {
    _dateTime = formatDateToIndonesia(DateTime.parse(dateTime));
    notifyListeners();
  }
}