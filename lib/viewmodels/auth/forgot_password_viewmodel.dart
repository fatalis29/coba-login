import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  String _merchantId = '';
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  String get merchantId => _merchantId;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isButtonEnabled => _merchantId.isNotEmpty && !_isLoading;

  // Setters
  void setMerchantId(String merchantId) {
    _merchantId = merchantId.trim();
    _errorMessage = ''; // Clear error when user types
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Business logic
  Future<void> submitForgotPassword() async {
    if (_merchantId.isEmpty) {
      setErrorMessage('Merchant ID tidak boleh kosong');
      return;
    }

    setLoading(true);
    setErrorMessage('');

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement actual forgot password API call here
      // Example:
      // final response = await authRepository.forgotPassword(_merchantId);
      
      // For now, we'll just simulate success
      print('Forgot password request sent for Merchant ID: $_merchantId');
      
    } catch (e) {
      setErrorMessage('Terjadi kesalahan. Silakan coba lagi.');
    } finally {
      setLoading(false);
    }
  }

  // Reset the form
  void reset() {
    _merchantId = '';
    _isLoading = false;
    _errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}