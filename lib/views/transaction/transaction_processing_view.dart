import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';

class TransactionProcessingView extends StatelessWidget {
  const TransactionProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          title: const AppBarTitle(title: 'Transaksi'),
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
          automaticallyImplyLeading: false,
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text('Masukkan Nominal Transaksi', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const LinearProgressIndicator(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: OutlinedButton(
                onPressed: () {}, 
                style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      style: BorderStyle.solid
                    )
                  )
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Batalkan Transaksi')
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}