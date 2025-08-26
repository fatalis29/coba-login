import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionQRView extends StatelessWidget {
  const TransactionQRView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ChangeNotifierProvider<TransactionViewModel>(
            create: (context) => TransactionViewModel(),
            child: Consumer<TransactionViewModel>(
              builder: (context, viewModel, child) {
                return Column(
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
                    Container(
                      decoration: const BoxDecoration(
                        // Gradient from a lighter to a darker turquoise
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF40E0D0), // Lighter top color
                            Color(0xFF008B8B), // Darker bottom color
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Text.rich(TextSpan(text: viewModel.merchantName.toUpperCase()), maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          // Text(viewModel.merchantId.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: viewModel.qrUrl != null ?
                              Image.network(
                                viewModel.qrUrl as String,
                                semanticLabel: 'QR Barcode',
                                fit:  BoxFit.fitWidth,
                              ) : 
                              Image.asset(
                                "assets/qrframe_small.jpeg",
                                semanticLabel: 'QR Barcode',
                                fit:  BoxFit.fitWidth
                              ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: QRCustomButton(
                                    icon: Icons.ios_share,
                                    text: 'Bagikan',
                                    onPressed: () {
                                      print("Scan QR button pressed");
                                    },
                                    backgroundColor: const Color.fromARGB(255, 30, 99, 99),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: QRCustomButton(
                                    icon: Icons.download,
                                    text: 'Download',
                                    onPressed: () {
                                      print("QR Statis button pressed");
                                    },
                                    backgroundColor: const Color.fromARGB(255, 30, 99, 99),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: OutlinedButton(
                        onPressed: () {
                          context.goNamed(Routes.inputNominalTransaksi.routeName);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orange, width: 2),
                          foregroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Input QRIS Nominal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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


class QRCustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final double iconSize;
  final double fontSize;

  const QRCustomButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.width,
    this.height,
    this.borderRadius = 20.0,
    this.iconSize = 24.0,
    this.fontSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 56.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color.fromARGB(255, 130, 191, 191),
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Colors.white,
            ),
            const SizedBox(width: 12.0),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}