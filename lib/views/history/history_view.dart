import 'package:dbank/models/history_item.dart';
import 'package:dbank/routes/routes.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:dbank/viewmodels/history/history_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/text_field_custom.dart';
import 'package:dbank/views/components/history_listview_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
                    leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
      ),
      body: ChangeNotifierProvider<HistoryViewModel>(
        create: (context) => HistoryViewModel(),
        child: Consumer<HistoryViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text('Riwayat Transaksi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(height: 4),
                Container(
                  color: Theme.of(context).colorScheme.background,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF40E0D0), // Light Teal
                          Color(0xFF008B8B), // Dark Teal
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Stack(
                      children: [
                        // SVG with fixed size, not affected by padding
                        Align(
                          alignment: Alignment.topRight, // You can change to bottomCenter etc.
                          child: SvgPicture.asset(
                            'assets/ribbon-trans-history.svg',
                            width: 80, // Adjust width or height as needed
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Column with padding
                        Padding(
                          padding: const EdgeInsets.all(16), // Only applied to Column
                          child: Align (
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Text(
                                  '${formatDateToIndonesia(viewModel.startDate)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                buildRupiahText(
                                  viewModel.nominal,
                                  currencyFontSize: 12,
                                  amountFontSize: 32,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  ,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  tileColor: Theme.of(context).colorScheme.surface,
                  title: Row( // Remove 'const' here
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SearchBarWidget(), // Keep const here since SearchBarWidget doesn't need viewModel
                      const SizedBox(width: 16), // Keep const here
                      CalendarButtonWidget(viewModel: viewModel), // Pass the viewModel here
                    ],
                  )
                ),
                 viewModel.historyItemsFiltered.isNotEmpty ? 
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      itemCount: viewModel.historyItemsFiltered.keys.length,
                      controller: viewModel.controller,
                      itemBuilder: (context, index) {
                      return Column(
                        children: [
                          //tanggal gituans
                          // Container(
                          //   color: Theme.of(context).colorScheme.background,
                          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          //   alignment: Alignment.centerLeft,
                          //   child: Text("${viewModel.historyItemsFiltered.keys.elementAt(index)}"),
                          // ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            alignment: Alignment.centerLeft,
                            child:
                            Column(
                              children:[
                                ...viewModel.historyItemsFiltered.values.elementAt(index).map((HistoryListItem? item) {
                                  return HistoryListItemWidget(
                                    item: item!,
                                    onTap: () {
                                      print(item.id.toString());
                                      context.pushNamed(Routes.detailRiwayatTransaksi.routeName, pathParameters: {'id': item.id.toString()});
                                    },
                                  );
                                }).toList(),
                              ]
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ) : const Expanded(child: SizedBox()),
              ],
            );
          },
        ),
      )
      );
  }
}


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Expanded is used so the search bar fills the available space in the Row
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Cari nama customer',
            prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 69, 68, 68)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarButtonWidget extends StatelessWidget {
  final HistoryViewModel viewModel; // Add viewModel parameter
  
  const CalendarButtonWidget({
    super.key,
    required this.viewModel, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, // Fixed width
      height: 48, // Fixed height to match typical search bar height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.calendar_today_outlined, color: Color.fromARGB(255, 69, 68, 68)),
        onPressed: () {
          // Function to show the date picker
          _selectDate(context);
        },
      ),
    );
  }

  // Helper function to show the Date Picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    this.viewModel.getDummyData();
  }
}


Widget buildRupiahText(double amount, {
  double currencyFontSize = 16,
  double amountFontSize = 28,
  Color? textColor = Colors.white,
  FontWeight? fontWeight = FontWeight.bold,
}) {
  // Get the formatted number without currency symbol
  var formatter = NumberFormat('#,##0', 'id');
  String formattedAmount = formatter.format(amount);
  
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start, // This aligns "Rp" to the top
    children: [
      Text(
        'Rp ',
        style: TextStyle(
          fontSize: currencyFontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
      Text(
        formattedAmount,
        style: TextStyle(
          fontSize: amountFontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
    ],
  );
}

