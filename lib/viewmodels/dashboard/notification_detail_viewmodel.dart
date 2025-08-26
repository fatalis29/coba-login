import 'package:dbank/models/ui_model_status.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:flutter/material.dart';

class NotificationDetailViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  // Notification detail data
  String notificationId;

  String _title = 'Test Notifikasi 1';
  DateTime _time = DateTime.now();
  String _body = 'Gambar 1 miaw :3';
  String? _imgSrc;

  String get title => _title;
  String get time => formatDateToIndonesia(_time, format: 'dd MMMM yyyy, hh:mm');
  String get body => _body;
  String? get imgSrc => _imgSrc;

  NotificationDetailViewModel({required this.notificationId});

  // Functions
  void getNotificationDetail() {
    // TODO: fetch detail here 
    notifyListeners();
  }

}