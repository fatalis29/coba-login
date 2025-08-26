import 'package:flutter/material.dart';

enum UIModelStatus {
  Ended,
  Loading,
  Error,
}

class ChangePasswordViewModel extends ChangeNotifier {
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  UIModelStatus get status => _status;
  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  // Form states
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  bool _hiddenOldPassword = true;
  bool _hiddenNewPassword = true;
  bool _hiddenConfirmPassword = true;

  // Getters
  String get oldPassword => _oldPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  bool get hiddenOldPassword => _hiddenOldPassword;
  bool get hiddenNewPassword => _hiddenNewPassword;
  bool get hiddenConfirmPassword => _hiddenConfirmPassword;

  bool get isLoading => _status == UIModelStatus.Loading;
  bool get isButtonEnabled => 
      _oldPassword.isNotEmpty && 
      _newPassword.isNotEmpty && 
      _confirmPassword.isNotEmpty && 
      !isLoading;

  ChangePasswordViewModel();

  // Setters similar to ChangePinViewModel
  void setOldPassword(String password) {
    _oldPassword = password;
    _errorMessage = ''; // Clear error when user types
    notifyListeners();
    print("setOldPassword: $password");
  }

  void setNewPassword(String password) {
    _newPassword = password;
    _errorMessage = ''; // Clear error when user types
    notifyListeners();
    print("setNewPassword: $password");
  }

  void setConfirmPassword(String password) {
    _confirmPassword = password;
    _errorMessage = ''; // Clear error when user types
    notifyListeners();
    print("setConfirmPassword: $password");
  }

  // Toggle visibility methods similar to ChangePinViewModel pattern
  void toggleOldPasswordVisibility() {
    _hiddenOldPassword = !_hiddenOldPassword;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _hiddenNewPassword = !_hiddenNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _hiddenConfirmPassword = !_hiddenConfirmPassword;
    notifyListeners();
  }

  // Set UI status
  void setStatus(UIModelStatus status) {
    _status = status;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    _status = UIModelStatus.Error;
    notifyListeners();
  }

  void setErrorCode(String code) {
    _errorCode = code;
    notifyListeners();
  }

  // Main submit method similar to submitLoginInfo in ChangePinViewModel
  void submitPasswordInfo() {
    print("submitting password info");
    print("Old Password: $_oldPassword");
    print("New Password: $_newPassword");
    print("Confirm Password: $_confirmPassword");
    
    // Validation
    if (_oldPassword.isEmpty) {
      setErrorMessage('Password saat ini tidak boleh kosong');
      return;
    }

    if (_newPassword.isEmpty) {
      setErrorMessage('Password baru tidak boleh kosong');
      return;
    }

    if (_confirmPassword.isEmpty) {
      setErrorMessage('Konfirmasi password tidak boleh kosong');
      return;
    }

    if (_newPassword != _confirmPassword) {
      setErrorMessage('Password baru dan konfirmasi password tidak cocok');
      return;
    }

    if (_newPassword.length < 8) {
      setErrorMessage('Password baru minimal 8 karakter');
      return;
    }

    if (_oldPassword == _newPassword) {
      setErrorMessage('Password baru harus berbeda dari password saat ini');
      return;
    }

    // Clear form after successful validation
    _oldPassword = '';
    _newPassword = '';
    _confirmPassword = '';
    _errorMessage = '';
    _status = UIModelStatus.Ended;
    notifyListeners();
  }

  // Async method for actual API call
  Future<void> submitPasswordChange() async {
    setStatus(UIModelStatus.Loading);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Implement actual change password API call here
      // Example:
      // final response = await authRepository.changePassword(_oldPassword, _newPassword);
      
      // For now, we'll just simulate success
      print('Password changed successfully');
      
      // Reset form on success
      _oldPassword = '';
      _newPassword = '';
      _confirmPassword = '';
      setStatus(UIModelStatus.Ended);
      
    } catch (e) {
      setErrorMessage('Terjadi kesalahan saat mengubah password. Silakan coba lagi.');
    }
  }

  // Reset the form
  void reset() {
    _oldPassword = '';
    _newPassword = '';
    _confirmPassword = '';
    _status = UIModelStatus.Ended;
    _errorCode = '';
    _errorMessage = '';
    _hiddenOldPassword = true;
    _hiddenNewPassword = true;
    _hiddenConfirmPassword = true;
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}