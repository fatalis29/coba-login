import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/forms.dart';
import 'package:dbank/views/components/text_field_rupiah_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionManualView extends StatelessWidget {
  // const TransactionManualView({super.key, required this.viewModel});
  // final TransactionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionViewModel>(
      create: (context) => TransactionViewModel(),
      child: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
                title: const AppBarTitle(title: 'Transaksi'),
                centerTitle: true,
                shadowColor: Theme.of(context).colorScheme.shadow,
                leading: IconButton(icon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary), onPressed: () => context.pop()),
              ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text('Masukkan Nominal Transaksi', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                  ListTile(
                    contentPadding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    tileColor: Theme.of(context).colorScheme.surface,
                    title: TextFieldRupiahFormat(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: FormFieldItem(
                      fieldTitle: 'Nomor Ponsel D-Wallet Nasabah',
                      inputType: TextInputType.phone,
                      visibleCounter: false,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: FilledButton(
                      //onPressed: () => viewModel.submitTransactionAmount(),
                      onPressed: () {
                        // viewModel.addCheck();
                      }, 
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Lanjut')
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}