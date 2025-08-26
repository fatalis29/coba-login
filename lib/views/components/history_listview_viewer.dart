import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dbank/models/history_item.dart';

class HistoryListItemWidget extends StatelessWidget {
  final HistoryListItem item;
  final VoidCallback? onTap;

  const HistoryListItemWidget({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  String _getTransactionTypeText(TransactionType type) {
    switch (type) {
      case TransactionType.pembayaranMasuk:
        return 'Pembayaran Masuk';
      case TransactionType.pembayaranKeluar:
        return 'Pembayaran Keluar';
      case TransactionType.refund:
        return 'Refund';
    }
  }

  Color _getAmountColor(TransactionType type) {
    switch (type) {
      case TransactionType.pembayaranMasuk:
        return Colors.green;
      case TransactionType.pembayaranKeluar:
        return Colors.red;
      case TransactionType.refund:
        return Colors.orange;
    }
  }

  String _getAmountPrefix(TransactionType type) {
    switch (type) {
      case TransactionType.pembayaranMasuk:
        return '+ ';
      case TransactionType.pembayaranKeluar:
        return '- ';
      case TransactionType.refund:
        return '+ ';
    }
  }

  String _formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            // Left side content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(item.dateTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Bank name
                  Text(
                    item.bankName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Transaction type and amount row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getTransactionTypeText(item.transactionType),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${_getAmountPrefix(item.transactionType)}${_formatCurrency(item.nominal)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _getAmountColor(item.transactionType),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}