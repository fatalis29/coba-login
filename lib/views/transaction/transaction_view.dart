import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/text_field_rupiah_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: const Text(
                'Transaksi QRIS', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              contentPadding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              tileColor: Theme.of(context).colorScheme.surface,
              title: TextFieldRupiahFormat(),
            ),
            const Expanded(child: SizedBox()),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: FilledButton(
                onPressed: () {}, 
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xfffe0be36)),
                  foregroundColor: MaterialStateProperty.all(Color(0xFF000000)) // Add FF for full opacity
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}