import 'package:flutter/foundation.dart';

class SuccessViewModel extends ChangeNotifier {
  // Private variables
  double _nominal = 0.0;
  String _namaNasabah = '';
  String _asalBank = '';
  bool _isRefund = false;

  // Getters
  double get nominal => _nominal;
  String get namaNasabah => _namaNasabah;
  String get asalBank => _asalBank;
  bool get isRefund => _isRefund;

  // Formatted nominal getter
  String get formattedNominal {
    return 'Rp ${_nominal.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  // Setters
  void setNominal(double value) {
    _nominal = value;
    notifyListeners();
  }

  void setNamaNasabah(String value) {
    _namaNasabah = value;
    notifyListeners();
  }

  void setAsalBank(String value) {
    _asalBank = value;
    notifyListeners();
  }

  void setIsRefund(bool value) {
    _isRefund = value;
    notifyListeners();
  }

  // Method to set all transaction data at once
  void setTransactionData({
    required double nominal,
    required String namaNasabah,
    required String asalBank,
    required bool isRefund,
  }) {
    _nominal = nominal;
    _namaNasabah = namaNasabah;
    _asalBank = asalBank;
    _isRefund = isRefund;
    notifyListeners();
  }

  // Method to clear all data
  void clearData() {
    _nominal = 0.0;
    _namaNasabah = '';
    _asalBank = '';
    _isRefund = false;
    notifyListeners();
  }

  // Method to get transaction type
  String get transactionType => _isRefund ? 'Refund' : 'Pembayaran';
}