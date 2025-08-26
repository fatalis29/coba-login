import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionManualConfirmationView extends StatelessWidget {
  const TransactionManualConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Text.rich(TextSpan(text: 'Anda akan meminta Nasabah dengan D-Wallet berikut untuk melakukan pembayaran:'), maxLines: 2, style: TextStyle(fontSize: 12)),
            ),
            ListTile(
              contentPadding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              tileColor: Theme.of(context).colorScheme.surface,
              title: Row(
                children: [
                  Column(
                    children: [
                      Text('Nama Nasabah'),
                      Text('Nomor Ponsel')
                    ],
                  ),
                  Column(
                    children: [
                      Text('Nama Nasabah', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Nomor Ponsel', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              )
            ),
            const Divider(thickness: 0.5),
            ListTile(
              contentPadding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              tileColor: Theme.of(context).colorScheme.surface,
              title: Row(
                children: [
                  Text('Nominal Transaksi'),
                  Text('Nama Nasabah')
                ],
              )
            ),
            const Expanded(child: SizedBox()),
            Text.rich(TextSpan(text: 'Pastikan transaksi yang Anda masukkan sudah benar'), maxLines: 2, style: TextStyle(fontSize: 12)),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: FilledButton(
                //onPressed: () => viewModel.submitTransactionAmount(),
                onPressed: () {}, 
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Proses')
                )
              ),
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: FilledButton.tonal(
                //onPressed: () => viewModel.submitTransactionAmount(),
                onPressed: () {}, 
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Batal')
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}