import 'package:dbank/routes/route.dart';

final class Routes {
  static Route login = Route(routeName: 'Login', routeUrl: '/login');
  static Route dashboard = Route(routeName: 'Dashboard', routeUrl: '/');
  // transaksi
  static Route qrStatis = Route(routeName: 'QR Statis', routeUrl: '/transaction', routeSubUrl: 'transaction');
  static Route inputNominalTransaksi = Route(routeName: 'Input Nominal Transaksi', routeUrl: '/transaction/nominal-input', routeSubUrl: 'nominal-input');
  static Route qrNominalTransaksi = Route(routeName: 'QR Nominal', routeUrl: '/transaction/qr-nominal');
  // status transaksi
  static Route success = Route(routeName: 'Transaction Success', routeUrl: '/transaction/success', routeSubUrl: 'transaction/success');
  static Route failed = Route(routeName: 'Transaction Failed', routeUrl: '/transaction/failed', routeSubUrl: 'transaction/failed');
  // riwayat transaksi
  static Route riwayatTransaksi = Route(routeName: 'Riwayat Transaksi', routeUrl: '/history', routeSubUrl: 'history');
  static Route detailRiwayatTransaksi = Route(routeName: "Detail Riwayat Transaksi", routeUrl: '/history/detail/:id', routeSubUrl: 'detail/:id');
  // refund
  static Route refund = Route(routeName: 'Refund', routeUrl: '/history/detail/:id/refund', routeSubUrl: 'refund');
  static Route konfirmasiRefund = Route(routeName: 'Refund Confirmation', routeUrl: '/history/detail/:id/refund/confirmation', routeSubUrl: 'confirmation');
  // notifikasi
  static Route notifikasi = Route(routeName: 'Notification', routeUrl: '/notification', routeSubUrl: 'notification');
  static Route detailNotifikasi = Route(routeName: 'Notification Detail', routeUrl: '/notification/:id', routeSubUrl: ':id');
  // pengaturan
  static Route pengaturan = Route(routeName: 'Pengaturan', routeUrl: '/settings', routeSubUrl: 'settings');
  static Route profil = Route(routeName: 'Profil Merchant', routeUrl: '/settings/profile', routeSubUrl: 'profile');
  static Route ubahPin = Route(routeName: 'Ubah PIN', routeUrl: '/settings/changepin', routeSubUrl: 'changepin');
  static Route changePassword = Route(routeName: 'Ubah Password', routeUrl: '/settings/changepassword', routeSubUrl: 'changepassword');
  // lupa password
  static Route lupaPassword = Route(routeName: 'Lupa Password', routeUrl: '/forgot-password');
  static Route otpInput = Route(routeName: 'otp input', routeUrl: '/forgot-password/otp-input');

  static Route insertPassword = Route(routeName: 'Insert Password', routeUrl: '/insert-password');
  // splash screen
}