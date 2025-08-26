import 'package:dbank/models/history_item.dart';
import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/history/history_detail_viewmodel.dart';
import 'package:dbank/views/components/table_detail.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// field yang ga ada 
// - total transaksi
// - tips 

class HistoryDetailView extends StatelessWidget {
  final String transactionId;
  HistoryDetailView({required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
                    leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
      ),
      body: ChangeNotifierProvider<HistoryDetailViewModel>(
        create: (context) => HistoryDetailViewModel(transactionId),
        child: Consumer<HistoryDetailViewModel>(
          builder: (context, viewModel, child) {
            Iterable<TableRow>? refundDetailSegment = viewModel.isRefunded ? [
              TableRowSpacer(),
              TableRowDetail(rowTitle: 'Detail Refund'),
              TableRowDetail(rowTitle: 'Tanggal', rowContent: (viewModel.date)),
              TableRowDetail(rowTitle: 'Jam', rowContent: 'Nama nasabah'),
              TableRowDetail(rowTitle: 'Nominal', rowContent: viewModel.refundNominal.toString()),
              TableRowDetail(rowTitle: 'Status Refund', rowContent: viewModel.refundStatus?.string, customStyle: viewModel.refundStatus?.style),
            ] : null;
            
            // Replace your existing Column with this one.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: const Text('Detail Transaksi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(height: 4),

                Expanded(
                  child: SingleChildScrollView(
                    child: 
                    Column(
                      children: [
                        Column
                        (
                          children: [
                            if (true) // change to  viewModel.isRefunded in prod
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: TransaksiStatusWidget(isTransaksiAwal: true),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // First Section
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.2), // Give title a bit more space
                                      1: FlexColumnWidth(1.5),
                                    },
                                    children: [
                                      TableRowDetail(
                                        rowTitle: 'Total Transaksi',
                                        rowContent: viewModel.nominal,
                                        customStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Nama Nasabah',
                                        rowContent: viewModel.namaNasabah,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Aplikasi Issuer',
                                        rowContent: viewModel.appliaction, // Assuming typo for 'application'
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Tanggal',
                                        rowContent: viewModel.date,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Jam',
                                        rowContent: viewModel.time,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Status',
                                        rowContent: 'Berhasil', // Placeholder from image
                                        customStyle: const TextStyle(
                                          color: Color(0xFF2E7D32), // Green color
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Divider between sections
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: CustomPaint(
                                      size: const Size(double.infinity, 1),
                                      painter: DottedLinePainter(),
                                    ),
                                  ),
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.2),
                                      1: FlexColumnWidth(1.5),
                                    },
                                    children: [
                                      TableRowDetail(rowTitle: 'DETAIL TRANSAKSI'), // Header row
                                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8)]),
                                      TableRowDetail(
                                        rowTitle: 'Nominal Transaksi',
                                        // Corrected Binding
                                        rowContent: viewModel.nominal,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Tips',
                                        // NOTE: You mapped 'viewModel.terminalId' here.
                                        // The image shows "Rp 0".
                                        rowContent: 'Rp 0', // Placeholder from image
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Total Transaksi',
                                        // Corrected Binding
                                        rowContent: viewModel.nominal,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'No. Ref Transaksi',
                                        // Corrected Binding
                                        rowContent: viewModel.transactionRefNumber,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'RRN',
                                        // Corrected Binding
                                        rowContent: viewModel.rrn,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Customer PAN',
                                        // Corrected Binding
                                        rowContent: viewModel.customerPan,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Merchant PAN',
                                        // Corrected Binding
                                        rowContent: viewModel.merchantPan,
                                      ),
                                      // Your conditional refund segment is preserved here
                                      ...?refundDetailSegment
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        if(true) // replace with viewModel.isRefunded in prod
                        Column
                        (
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16),
                              child: TransaksiStatusWidget(isTransaksiAwal: false),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // First Section
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.2), // Give title a bit more space
                                      1: FlexColumnWidth(1.5),
                                    },
                                    children: [
                                      TableRowDetail(
                                        rowTitle: 'Nominal Refund',
                                        rowContent: viewModel.nominal,
                                        customStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Tanggal',
                                        rowContent: viewModel.date,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Jam',
                                        rowContent: viewModel.time,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'Status',
                                        rowContent: 'Berhasil', // Placeholder from image
                                        customStyle: const TextStyle(
                                          color: Color(0xFF2E7D32), // Green color
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Divider between sections
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: CustomPaint(
                                      size: const Size(double.infinity, 1),
                                      painter: DottedLinePainter(),
                                    ),
                                  ),
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(1.2),
                                      1: FlexColumnWidth(1.5),
                                    },
                                    children: [
                                      TableRowDetail(rowTitle: 'DETAIL REFUND'), // Header row
                                      const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8)]),
                                      TableRowDetail(
                                        rowTitle: 'No. Ref Transaksi',
                                        // Corrected Binding
                                        rowContent: viewModel.customerPan,
                                      ),
                                      TableRowDetail(
                                        rowTitle: 'RRN',
                                        // Corrected Binding
                                        rowContent: viewModel.merchantPan,
                                      ),
                                      // Your conditional refund segment is preserved here
                                      ...?refundDetailSegment
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        // Refund button - moved inside SingleChildScrollView
                        if(!viewModel.isRefunded)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: FilledButton(
                            onPressed: viewModel.isRefunded ? null : () {
                              context.pushNamed(Routes.refund.routeName, pathParameters: {'id': transactionId});
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFFFF00),
                              foregroundColor: const Color(0xFF008B8B),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Refund Transaksi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )
    );
  }
}



class TransaksiStatusWidget extends StatelessWidget {
  final bool isTransaksiAwal;

  const TransaksiStatusWidget({
    Key? key,
    required this.isTransaksiAwal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isTransaksiAwal 
            ? const Color.fromARGB(41, 0, 180, 165) // Light green background
            : const Color.fromARGB(147, 255, 235, 238), // Light red background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isTransaksiAwal 
                ? 'assets/icon/transaksi-awal.svg' 
                : 'assets/icon/transaksi-refund.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isTransaksiAwal ? 'Transaksi Awal' : 'Transaksi Refund',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Dark red
            ),
          ),
        ],
      ),
    );
  }
}