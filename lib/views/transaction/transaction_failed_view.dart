import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionFailedView extends StatelessWidget {
  final String failedType;
  final String failedMessage;
  
  const TransactionFailedView({super.key, required this.failedType, required this.failedMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: failedType),
        centerTitle: true,
        shadowColor: Theme.of(context).colorScheme.shadow,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ChangeNotifierProvider<TransactionViewModel>(
          create: (context) => TransactionViewModel(),
          child: Consumer<TransactionViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 64.0),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Image.asset('assets/trx_fail.png', fit: BoxFit.fitWidth, width: 128),
                          ),
                        ),
                        Text(failedMessage.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: OutlinedButton(
                      onPressed: () {
                        context.goNamed(Routes.dashboard.routeName);
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            style: BorderStyle.solid
                          )
                        )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Kembali ke Dashboard')
                      )
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      )
      );
  }
}