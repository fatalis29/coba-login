import 'package:flutter/material.dart';

enum UIModelStatus {
  Ended,
  Loading,
  Error,
}

class ChangePinViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  UIModelStatus get status => _status;
  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  // Form states
  late String _oldPin;
  late String _newPin;
  late String _confirmsNewPin;

  bool _hiddenOldPin = true;
  bool _hiddenNewPin = true;
  bool _hiddenconfirmsNewPin = true;

  String get oldPin => _oldPin;
  String get newPin => _newPin;
  String get confirmsNewPin => _confirmsNewPin;

  bool get hiddenOldPin => _hiddenOldPin;
  bool get hiddenNewPin => _hiddenNewPin;
  bool get hiddenConfirmsNewPin => _hiddenconfirmsNewPin;

  ChangePinViewModel();

  void setPin(String newPin) {
    // TODO:
    _newPin = newPin;
    print("setPin: $newPin");
  }

  void setOldPin(String oldPin) {
    _oldPin = oldPin;
    print("setOldPin: $oldPin");
  }

  void setConfirmsNewPin(String confirmsNewPin) {
    _confirmsNewPin = confirmsNewPin;
    print("setConfirmsNewPin: $confirmsNewPin");
  }

  void submitLoginInfo() {
    // TODO:
    print("submitting login info");
    print("Old Pin: $_oldPin");
    print("New Pin: $_newPin");
    print("Confirm New Pin: $_confirmsNewPin");
    _oldPin = '';
    _newPin = '';
    _confirmsNewPin = '';
  }

}