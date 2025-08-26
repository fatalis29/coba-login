import 'package:dbank/models/history_item.dart';
import 'package:dbank/models/refund_detail.dart';
import 'package:dbank/models/ui_model_status.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:flutter/material.dart';

class HistoryDetailViewModel extends ChangeNotifier{
  // UI States
  UIModelStatus _status = UIModelStatus.Ended;
  String _errorCode = '';
  String _errorMessage = '';

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  UIModelStatus get status => _status;

  // History Detail data
  late String _id;
  late HistoryItem _historyDetail;

  bool _isRefunded = false;
  bool get isRefunded => _isRefunded;

  String get namaNasabah => _historyDetail.customerName;
  String get appliaction => _historyDetail.application;
  String get customerPan => _historyDetail.customerPan;
  String get rrn => _historyDetail.rrn;
  String get merchantName => _historyDetail.merchantName;
  String get acquirer => _historyDetail.acquirer;
  String get merchantPan => _historyDetail.merchantPan;
  String get terminalId => _historyDetail.terminalId;
  String? get note => _historyDetail.note;
  String get date => formatDateToIndonesia(_historyDetail.dateTime.toLocal(), format: 'dd MMMM yyyy');
  String get time => "${formatDateToIndonesia(_historyDetail.dateTime.toLocal(), format: 'hh:mm')} WIB";
  String get nominal => "${formatToRupiah(_historyDetail.nominal)},-";
  String get transactionRefNumber => _historyDetail.transactionRefNumber;
  TransactionStatus get transactionStatus => _historyDetail.status;

  // Refund detail data
  RefundDetail? _refundDetail;
  String? get refundName => _refundDetail?.name;
  String? get refundApp => _refundDetail?.app;
  DateTime? get refundDateTune => _refundDetail?.date;
  double? get refundTransactionNominal => _refundDetail?.transactionNominal;
  double? get refundNominal => _refundDetail?.refundNominal;
  TransactionStatus? get refundStatus => _refundDetail?.refundStatus;

  HistoryDetailViewModel(String id) {
    _historyDetail = HistoryItem(
      customerName: '', 
      application: '', 
      customerPan: '', 
      rrn: '', 
      merchantName: '', 
      acquirer: '', 
      merchantPan: '', 
      terminalId: '', 
      dateTime: DateTime.now(), 
      nominal: 0, 
      transactionRefNumber: '', 
      status: TransactionStatus.Gagal
    );
    
    _id = id;
    getHistoryTransactionDetail(_id);
  }

  // Functions
  Future<void> getHistoryTransactionDetail(String id) async {
    // TODO: fetch data from internet
    await Future.delayed(const Duration(seconds: 1));
    
    _historyDetail = HistoryItem(customerName: "Ibnu Hanif", application: "BANK DANAMON", customerPan: '9360001113600000001', rrn: '705310382226', merchantName: 'merchant ilham', acquirer: 'BANK DANAMON', merchantPan: '9367701113600000345', terminalId: '0000552207', dateTime: DateTime.now(), nominal: 10000, transactionRefNumber: '145237', status: TransactionStatus.Berhasil);
    notifyListeners();
  }

  String getDate() {
    return _historyDetail.dateTime.toLocal().toString();
  }

  String getTime() {
    var localTime = _historyDetail.dateTime.toLocal();
    return '${localTime.hour.toString()}:${localTime.minute}';
  }

  void toggleRefund() {
    _isRefunded = !isRefunded;
    notifyListeners();
  }
}