import 'package:dbank/routes/routes.dart';
import 'package:dbank/utilities/utilities.dart';
import 'package:dbank/viewmodels/dashboard/dashboard_viewmodel.dart';
import 'package:dbank/views/components/custom_bottom_sheet.dart';
import 'package:dbank/views/components/route_debug_view.dart';
import 'package:dbank/views/components/show_exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showExitDialog(context); //TODO:
      },
      child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffcbf1f6), // 0% - 25%
                    Color(0xfff6e6cb), // 25% - 50%
                    Color(0xFFFFFFFF), // 50% - 100%
                  ],
                  stops: [0.0, 0.25, 0.5], // <- control the color distribution
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
          child:Scaffold(
            backgroundColor: Colors.transparent,
          appBar:
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 20),
            child: Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(top: 20),
              child: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                shadowColor: Theme.of(context).colorScheme.shadow,
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SvgPicture.asset(
                        'assets/logo-new.svg',
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    // Pengaturan Button
                    PengaturanButton(
                      onPressed: () {
                        context.pushNamed(Routes.pengaturan.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ChangeNotifierProvider<DashboardViewModel>(
              create: (context) => DashboardViewModel(),
              child: Consumer<DashboardViewModel>(
                builder: (context, viewModel, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // section 1
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Merchant name
                          Text(
                            viewModel.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color set to white
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 4),
                          // Merchant date
                          Text(
                            viewModel.dateTime,
                            style: const TextStyle(
                              wordSpacing: 2,
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Total Transaction
                          const Text(
                            'Total Transaksi Hari ini',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${formatToRupiah(viewModel.totalTransaction)},-',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20), // Less spacing to tighten layout
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              'assets/home/card-home.svg',
                              height: 180, // increase the height
                              width: double.infinity, // fill container width
                              fit: BoxFit.cover,
                              alignment: Alignment.centerLeft, // force align left
                            ),
                          ),
                        ],
                      ),
                    ),
                      const SizedBox(height: 16, width: 16),
                      // Tambah Transaksi Button
                      const SizedBox(height: 16, width: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // History Transaksi Button
                          CustomIconButton(
                            iconPath: 'assets/icon/riwayat-transaksi.svg',
                            title: 'Histori Transaksi',
                            onPressed: () {
                              context.pushNamed(Routes.riwayatTransaksi.routeName);
                            },
                          ),
                          // Pengaturan Button
                          CustomIconButton(
                            iconPath: 'assets/icon/mutasi.svg',
                            title: 'Unduh Laporan',
                            onPressed: () {
                              print("mengunduh laporan");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16, width: 16),
                      CustomIconButton(
                        iconPath: 'assets/icon/qris.svg',
                        title: 'Transaksi',
                        onPressed: () {
                          context.pushNamed(Routes.qrStatis.routeName);
                        },
                        textColor: const Color(0xFF4A4A4A),
                      ),
                      // ElevatedButton(onPressed: () {
                      //   showCustomBottomSheet(
                      //     context,
                      //     heading: 'Custom Bottom Sheet',
                      //     subHeading: 'This is a custom bottom sheet.',
                      //   );
                      // }, child: const Text('Show Bottom Sheet'))
                    ],
                  );
                },
              ),
            ),
          )
        ),
      ),
    );
  }
}


// page specifif widgets 
class PengaturanButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PengaturanButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( // Light mint background
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF4A4A4A),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFF00B4A6), // Teal color
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? iconSize;
  final double? fontSize;
  final String iconPath;
  final Color? textColor;

  const CustomIconButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.iconSize = 48,
    this.fontSize = 16,
    this.iconPath = 'assets/icon/qris.svg',
    this.textColor = const Color(0xFF2D2D2D),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: iconSize! + 16,
                height: iconSize! + 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  iconPath,
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? const Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Future<void> showCustomBottomSheet(
  BuildContext context, {
  required String heading,
  required String subHeading,
}) {
  return showModalBottomSheet<void>(
    context: context,
    // isScrollControlled allows the sheet to be taller
    isScrollControlled: true,
    // Make the corners rounded
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    builder: (BuildContext context) {
      // Return the custom widget
      return CustomBottomSheet(
        heading: heading,
        subHeading: subHeading,
      );
    },
  );
}