import 'package:dbank/models/refund_detail.dart';
import 'package:dbank/routes/routes.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:dbank/viewmodels/refund/refund_viewmodel.dart';
import 'package:dbank/views/components/table_detail.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/text_field_rupiah_format.dart';
import 'package:dbank/views/components/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RefundView extends StatelessWidget {
  final String transactionId; 
  const RefundView({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RefundViewModel>(
      create: (context) => RefundViewModel(transactionId),
      child: Consumer<RefundViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
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
                        child: Text('Refund Transaksi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      const SizedBox(height: 4),
                      ListTile(
                        contentPadding:  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        tileColor: Theme.of(context).colorScheme.background,
                        title: TextFieldRupiahFormat(
                          validator: (nominal) {
                            if (nominal == null || nominal.isEmpty) return null;
                            if (double.parse(nominal) > viewModel.transactionNominal) return "Nominal refund tidak bisa lebih besar dari nominal transaksi";
                            return null;
                          },
                          onChange: (nominal) {
                            if (nominal == null || nominal.isEmpty) return; 
                            viewModel.setRefundNominal(double.parse(nominal));
                          },
                          labelText: "Nominal Refund",
                          borderColor: Color.fromARGB(81, 110, 138, 142),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Added margin
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24), // Increased padding
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Table(
                              children: [
                                TableRowDetail(rowTitle: 'Nominal Transaksi', rowContent: formatToRupiah(viewModel.transactionNominal)),
                                TableRowDetail(rowTitle: 'Nama Nasabah', rowContent: viewModel.name),
                                TableRowDetail(rowTitle: 'Aplikasi Issuer', rowContent: viewModel.app),
                                TableRowDetail(rowTitle: 'Tanggal', rowContent: viewModel.date),
                                TableRowDetail(rowTitle: 'Jam', rowContent: viewModel.time),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 12.0),
                              child: CustomPaint(
                                size: const Size(double.infinity, 1),
                                painter: DottedLinePainter(),
                              ),
                            ),
                            Table(
                              children: [
                                  TableRowDetail(rowTitle: 'DETAIL TRANSAKSI'), // Header row
                                  const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8)]),
                                TableRowDetail(rowTitle: 'No. Ref Transaksi', rowContent: 'QR10000')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: FilledButton(
                                  onPressed: (viewModel.disabledButton) ? null : () {
                                    context.pushNamed(
                                      Routes.konfirmasiRefund.routeName,
                                      pathParameters: {'id': transactionId},
                                      extra: RefundDetail(name: viewModel.name, app: viewModel.app, date: viewModel.dateTime, transactionNominal: viewModel.transactionNominal, refundNominal: viewModel.refundNominal));
                                  }, 
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18), 
                                    child: Text('Lanjut')
                                  )
                                ),
                              ),
                              const SizedBox(height: 16)
                            ],
                          ),
                        ),
                      ),
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