import 'package:dbank/models/history_item.dart';
import 'package:dbank/models/ui_model_status.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

class HistoryViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';
  final ScrollController _controller = ScrollController();

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  ScrollController get controller =>_controller;

  // History data
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _customerSearchField = "";
  String _merchantIdSearchField = "";
  double _nominal = 0.0;
  List<HistoryListItem?> _historyItems = [];
  Map<String?, List<HistoryListItem?>> _historyItemsFiltered = {};

  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  String get customerSearchField => _customerSearchField;
  String get merchantIdSearchField => _merchantIdSearchField;
  double get nominal => _nominal;
  List<HistoryListItem?> get historyItems => _historyItems;
  Map<String?, List<HistoryListItem?>> get historyItemsFiltered => _historyItemsFiltered;

  HistoryViewModel();

  // Functions
  void setStartDate(DateTime newDate) {
    _startDate = newDate;
    notifyListeners();
  }

  void setEndDate(DateTime newDate) {
    _endDate = newDate;
    notifyListeners();
  }

  void setNominal(double newNominal) {
    _nominal = newNominal;
    notifyListeners();
  }

  Map<String?, List<HistoryListItem?>> groupHistoryItems() {
    return groupBy(historyItems, (item) => formatDateToIndonesia(item!.dateTime, format: 'dd MMMM yyyy'));
  }

  String? historyListItemsKey(int index) {
    return historyItemsFiltered.keys.elementAt(index);
  }

  void setMerchantIdSearchField(String newSearchKey) {
    _merchantIdSearchField = newSearchKey;
    filterHistoryItems();
  }

  void setCustomerSearchField(String newSearchKey) {
    _customerSearchField = newSearchKey;
    filterHistoryItems();
  }

  void filterHistoryItems() {
    if (historyItems.isEmpty) {
      notifyListeners();
      return;
    }

    var groupedItems = groupHistoryItems();

    if (merchantIdSearchField.isEmpty && customerSearchField.isEmpty) {
      _historyItemsFiltered = groupedItems;
      notifyListeners();
      return;
    }

    if(merchantIdSearchField.isNotEmpty && customerSearchField.isEmpty) {
      groupedItems.forEach((date, historyItems) {
        groupedItems[date] = historyItems.where((historyItem) => historyItem!.merchantId.contains(merchantIdSearchField)).toList();
      });
      groupedItems.removeWhere((key, value) => value.isEmpty);
      _historyItemsFiltered = groupedItems;
      notifyListeners();
      return;
    }

    if(merchantIdSearchField.isEmpty && customerSearchField.isNotEmpty) {
      groupedItems.forEach((date, historyItems) {
        groupedItems[date] = historyItems.where((historyItem) => historyItem!.name.contains(customerSearchField)).toList();
      });
      groupedItems.removeWhere((key, value) => value.isEmpty);
      _historyItemsFiltered = groupedItems;
      notifyListeners();
      return;
    }

    groupedItems.forEach((date, historyItems) {
      groupedItems[date] = historyItems.where((historyItem) {
        return historyItem!.name.contains(customerSearchField) && historyItem.merchantId.contains(merchantIdSearchField);
      }).toList();
    });
    groupedItems.removeWhere((key, value) => value.isEmpty);
    _historyItemsFiltered = groupedItems;
    notifyListeners();

    return;
  }

  void getDummyData() {
    List<HistoryListItem> historyListItems = [
      HistoryListItem(id: 1, name: 'name1', bankName: "bankName", transactionType: TransactionType.pembayaranMasuk, dateTime: DateTime.now(), nominal: 10000, merchantId: '1234567890'),
      HistoryListItem(id: 2, name: 'name2', bankName: "bankName", transactionType: TransactionType.pembayaranMasuk, dateTime: DateTime.now(), nominal: 50000000, merchantId: '1234567890'),
      HistoryListItem(id: 3, name: 'name2', bankName: "bankName", transactionType: TransactionType.refund, dateTime: DateTime.now(), nominal: 5000, merchantId: '1234567890')
    ];

    _historyItems = historyListItems;
    filterHistoryItems();
  }
}