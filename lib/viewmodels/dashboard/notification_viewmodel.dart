import 'package:dbank/models/ui_model_status.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  NotificationViewModel();

  // Notification data
  

  // Functions

}