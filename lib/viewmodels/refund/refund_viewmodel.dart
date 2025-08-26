import 'package:dbank/models/ui_model_status.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:flutter/material.dart';


class RefundViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  // Refund states
  String transactionId;

  String _name = '';
  String _app = '';
  DateTime _dateTime = DateTime.now();
  double _transactionNominal = 0;
  double _refundNominal = 0;
  bool _disabledButton = true;

  String get name => _name;
  String get app => _app;
  DateTime get dateTime => _dateTime; 
  String get date => formatDateToIndonesia(_dateTime, format: 'dd MMMM yyyy');
  String get time => formatDateToIndonesia(_dateTime, format: 'hh:mm');
  double get transactionNominal => _transactionNominal;
  double get refundNominal => _refundNominal;
  bool get disabledButton => _disabledButton;

  RefundViewModel(this.transactionId) {
    fetchTransactionDetail();
  }

  // Functions
  void setRefundNominal(double newNominal) {
    _refundNominal = newNominal;
    if (refundNominal > transactionNominal || refundNominal == 0) {
      _disabledButton = true;
    } else {
      _disabledButton = false;
    }
    notifyListeners();
  }

  Future<void> fetchTransactionDetail() async {
    // TODO: fetch transaction detail from internet


    notifyListeners();
  }

}