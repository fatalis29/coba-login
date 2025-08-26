import 'package:dbank/models/refund_detail.dart';
import 'package:dbank/repositories/session_manager.dart';
import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/transaction/transaction_viewmodel.dart';
import 'package:dbank/views/auth/forgot_password_view.dart'; // Add this import
import 'package:dbank/views/auth/insert_password_view.dart';
import 'package:dbank/views/auth/otp_input_view.dart';
import 'package:dbank/views/dashboard/dashboard_view.dart';
import 'package:dbank/views/dashboard/notification_detail_view.dart';
import 'package:dbank/views/dashboard/notification_view.dart';
import 'package:dbank/views/history/history_detail_view.dart';
import 'package:dbank/views/history/history_view.dart';
import 'package:dbank/views/login/login_view.dart';
import 'package:dbank/views/refund/refund_confirmation_view.dart';
import 'package:dbank/views/refund/refund_view.dart';
import 'package:dbank/views/settings/changepin_view.dart';
import 'package:dbank/views/settings/change_password_view.dart'; // Import ChangePasswordView
import 'package:dbank/views/settings/profile_view.dart';
import 'package:dbank/views/settings/settings_view.dart';
import 'package:dbank/views/transaction/transaction_failed_view.dart';
import 'package:dbank/views/transaction/transaction_qr_view.dart';
import 'package:dbank/views/transaction/transaction_view.dart';
import 'package:dbank/views/transaction/success_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  final secureStorage = SecureStorageSingleton();
  TransactionViewModel transactionViewModel = TransactionViewModel();
  late GoRouter route = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.detailRiwayatTransaksi.routeUrl, // Set initial location to OTP input
    routes: [
      GoRoute(
        path: Routes.login.routeUrl,
        name: Routes.login.routeName,
        builder:(context, state) => LoginView(),
      ),
      GoRoute(
        path: Routes.lupaPassword.routeUrl, // Add forgot password route
        name: Routes.lupaPassword.routeName,
        builder:(context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: Routes.otpInput.routeUrl,
        name: Routes.otpInput.routeName,
        builder: (context, state) => const OTPInputView(),
      ),
      GoRoute(
        path: Routes.insertPassword.routeUrl,
        name: Routes.insertPassword.routeName,
        builder: (context, state) => InsertPasswordView(),
      ),
      GoRoute(
        path: Routes.dashboard.routeUrl,
        name: Routes.dashboard.routeName,
        builder:(context, state) => DashboardView(),
        routes: [
          GoRoute(
            path: Routes.notifikasi.routeSubUrl as String,
            name: Routes.notifikasi.routeName,
            builder:(context, state) => NotificationView(),
            routes: [
              GoRoute(
                path: Routes.detailNotifikasi.routeSubUrl as String,
                name: Routes.detailNotifikasi.routeName,
                builder: (context, state) => NotificationDetailView(notificationId: state.pathParameters['id'] as String),
              )
            ]
          ),
          GoRoute(
            path: Routes.qrStatis.routeSubUrl as String,
            name: Routes.qrStatis.routeName,
            builder: (context, state) => TransactionQRView(),
            routes: [
              GoRoute(
                path: Routes.inputNominalTransaksi.routeSubUrl as String,
                name: Routes.inputNominalTransaksi.routeName,
                builder: (context, state) => TransactionView(),  
              ),
            ]
          ),
          GoRoute(
            path: Routes.success.routeSubUrl as String,
            name: Routes.success.routeName,
            builder: (context, state) => const SuccessPage(),
          ),
          GoRoute(
            path: Routes.failed.routeSubUrl as String,
            name: Routes.failed.routeName,
            builder: (context, state) => TransactionFailedView(failedType: state.pathParameters['failedType'] as String, failedMessage: state.pathParameters['failedMessage'] as String), 
          ),
          GoRoute(
            path: Routes.riwayatTransaksi.routeSubUrl as String,
            name: Routes.riwayatTransaksi.routeName,
            builder: (context, state) => HistoryView(),
            routes: [
              GoRoute(
                path: Routes.detailRiwayatTransaksi.routeSubUrl as String,
                name: Routes.detailRiwayatTransaksi.routeName,
                builder:(context, state) => HistoryDetailView(transactionId: state.pathParameters['id'] as String),
                routes: [
                  GoRoute(
                    path: Routes.refund.routeSubUrl as String,
                    name: Routes.refund.routeName,
                    builder: (context, state) => RefundView(transactionId: state.pathParameters['id'] as String),
                    routes: [
                      GoRoute(
                        path: Routes.konfirmasiRefund.routeSubUrl as String,
                        name: Routes.konfirmasiRefund.routeName,
                        builder: (context, state) {
                          // Use state.extra if available, otherwise create a default RefundDetail object.
                          final details = state.extra as RefundDetail?;
                          return RefundConfirmationView(
                            details: details ??
                                RefundDetail(
                                  name: 'Contoh Merchant',
                                  app: 'QRIS',
                                  date: DateTime.now(),
                                  transactionNominal: 100000,
                                  refundNominal: 100000,
                                ),
                          );
                        },
                      )
                    ]
                  ),
                ]
              )
            ]
          ),
          GoRoute(
            path: Routes.pengaturan.routeSubUrl as String,
            name: Routes.pengaturan.routeName,
            builder: (context, state) => SettingsView(), 
            routes: [
              GoRoute(
                path: Routes.profil.routeSubUrl as String,
                name: Routes.profil.routeName,
                builder: (context, state) => ProfileView(),  
              ),
              GoRoute(
                path: Routes.ubahPin.routeSubUrl as String,
                name: Routes.ubahPin.routeName,
                builder:(context, state) => ChangePinView(),
              ),
              GoRoute(
                path: Routes.changePassword.routeSubUrl as String, // Add route for ChangePasswordView
                name: Routes.changePassword.routeName,
                builder: (context, state) => ChangePasswordView(),
              )
            ] 
          ),
        ]
      ),
    ],
    redirect: (context, state) async {

      bool loggedIn = checkSession(await secureStorage.getValue('session')); // TODO: check session
      bool isLoggingIn = state.path == Routes.login.routeUrl;
      bool isForgotPassword = state.path == Routes.lupaPassword.routeUrl; // Add this check

      // logged out
      if(!loggedIn) {
        return (isLoggingIn || isForgotPassword) ? null : Routes.login.routeUrl; // Allow access to forgot password
      }

      // logged in from login screen or forgot password screen
      if(isLoggingIn || isForgotPassword) {
        return Routes.dashboard.routeUrl;
      }

      // logged in from session
      return null;
    },
  );
}