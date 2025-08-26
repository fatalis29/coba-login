import 'package:flutter/foundation.dart';

class InsertPasswordViewModel extends ChangeNotifier {
  String _pin = '';
  bool _isLoading = false;

  String get pin => _pin;
  bool get isLoading => _isLoading;
  bool get isPinComplete => _pin.length == 6;

  void updatePin(String newPin) {
    _pin = newPin;
    notifyListeners();
    
    // Check if PIN is complete and trigger action
    if (isPinComplete) {
      _onPinComplete();
    }
  }

  void clearPin() {
    _pin = '';
    notifyListeners();
  }

  void _onPinComplete() {
    // Dummy function - print the PIN when all 6 digits are filled
    print('PIN entered: $_pin');
    
    // You can add authentication logic here
    _submitPin();
  }

  Future<void> _submitPin() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call or authentication
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();

    // Add success/failure handling here
    print('PIN submitted successfully: $_pin');
  }
}