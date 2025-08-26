import 'package:flutter/material.dart';

class OTPInputViewModel extends ChangeNotifier {
  String _merchantId = '0924734729328';
  String _otp = '';
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  String get merchantId => _merchantId;
  String get otp => _otp;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isButtonEnabled => _merchantId.isNotEmpty && _otp.isNotEmpty && !_isLoading;

  // Setters
  void setMerchantId(String merchantId) {
    _merchantId = merchantId.trim();
    _errorMessage = ''; // Clear error when user types
    notifyListeners();
  }

  void setOTP(String otp) {
    _otp = otp.trim();
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
  Future<void> verifyOTP() async {
    if (_merchantId.isEmpty) {
      setErrorMessage('Merchant ID tidak boleh kosong');
      return;
    }

    if (_otp.isEmpty) {
      setErrorMessage('OTP tidak boleh kosong');
      return;
    }

    if (_otp.length != 6) {
      setErrorMessage('OTP harus 6 digit');
      return;
    }

    setLoading(true);
    setErrorMessage('');

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement actual OTP verification API call here
      // Example:
      // final response = await authRepository.verifyOTP(_merchantId, _otp);
      
      // For now, we'll just simulate success
      print('OTP verification for Merchant ID: $_merchantId, OTP: $_otp');
      
    } catch (e) {
      setErrorMessage('OTP tidak valid. Silakan coba lagi.');
    } finally {
      setLoading(false);
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (_merchantId.isEmpty) {
      setErrorMessage('Merchant ID tidak boleh kosong');
      return;
    }

    setLoading(true);
    setErrorMessage('');

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual resend OTP API call here
      // Example:
      // final response = await authRepository.resendOTP(_merchantId);
      
      print('OTP resent for Merchant ID: $_merchantId');
      
    } catch (e) {
      setErrorMessage('Gagal mengirim ulang OTP. Silakan coba lagi.');
    } finally {
      setLoading(false);
    }
  }

  // Reset the form
  void reset() {
    _merchantId = '';
    _otp = '';
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