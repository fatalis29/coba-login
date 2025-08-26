import 'package:flutter/material.dart';

enum UIModelStatus {
  Ended,
  Loading,
  Error,
}

class ProfileViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;


  // Profile data
  String _name = '';
  String _merchantId = '';
  String _merchantName = '';
  String _address = '';
  String _email = '';
  String _picName = '';
  String _picPhoneNumber = '';
  String _picNIK = '';
  String _bankName = '';
  String _accountName = '';

  String get name => _name;
  String get merchantId => _merchantId;
  String get merchantName => _merchantName;
  String get address => _address;
  String get email => _email;
  String get picName => _picName;
  String get picPhoneNumber => _picPhoneNumber;
  String get picNIK => _picNIK;
  String get bankName => _bankName;
  String get accountName => _accountName;

  ProfileViewModel() {
    getProfileData();
  }

  // Functions
  Future<void> getProfileData() async {
    _status = UIModelStatus.Loading;
    notifyListeners();

    // TODO: fetch data from internet
    await Future.delayed(const Duration(seconds: 1));

    _status = UIModelStatus.Ended;
    notifyListeners();
  }
}