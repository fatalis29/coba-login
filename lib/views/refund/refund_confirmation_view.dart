import 'package:dbank/models/refund_detail.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RefundConfirmationView extends StatelessWidget {
  final RefundDetail details;
  const RefundConfirmationView({super.key, required this.details});
  

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontSize: 14,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionViewModel>(
      create: (context) => TransactionViewModel(),
      child: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
                centerTitle: true,
                shadowColor: Theme.of(context).colorScheme.shadow,
                leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
              ),
            body: LayoutBuilder(
              builder: (context, constraints) => CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Text('Konfirmasi Refund', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            // Header section with colored background
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 213, 222),
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Nominal Refund',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '- ${formatToRupiah(details.refundNominal)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Body section with transaction details
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  _buildDetailRow('Total Transaksi', '+ ${formatToRupiah(details.transactionNominal)}'),
                                  const SizedBox(height: 12),
                                  _buildDetailRow('Nama Nasabah', details.name),
                                  const SizedBox(height: 12),
                                  _buildDetailRow('Aplikasi Issuer', details.app),
                                  const SizedBox(height: 12),
                                  _buildDetailRow('Tanggal', formatDateToIndonesia(details.date, format: 'd MMMM y')),
                                  const SizedBox(height: 12),
                                  _buildDetailRow('Jam', formatDateToIndonesia(details.date, format: 'HH:mm') + ' WIB'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.amber[500],
                            foregroundColor: Colors.black
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Konfirmasi')
                          )
                        ),
                      ),
                      const SizedBox(height: 32)
                    ],
                  ),
                )]
              ),
            ),
          );
        }
      )
    );
  }
}