import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionSuccessView extends StatelessWidget {
  const TransactionSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Berhasil'),
        centerTitle: true,
        shadowColor: Theme.of(context).colorScheme.shadow,
        leading: IconButton(icon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.primary), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ChangeNotifierProvider<TransactionViewModel>(
            create: (context) => TransactionViewModel(),
            child: Consumer<TransactionViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/trx_succ.png', fit: BoxFit.contain, scale: 48.0),
                    Text('TRANSAKSI BERHASIL'.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                    Text('Nama Akun', textAlign: TextAlign.center),
                    Text('D-Wallet provider (BANK)', textAlign: TextAlign.center),
                    Text('Nominal Transaksi', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                    Text('75.000', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: FilledButton(
                        onPressed: () {

                        }, 
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text('Lihat Transaksi')
                        )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: OutlinedButton(
                        onPressed: () {
                          
                        }, 
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).colorScheme.primary),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text('Kembali ke Dashboard')
                        )
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      )
    );
  }
}