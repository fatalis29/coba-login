import 'package:dbank/repositories/session_manager.dart';
import 'package:dbank/routes/app_router.dart';
import 'package:dbank/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final secureStorage = SecureStorageSingleton();
  await secureStorage.initialize(); 
  await initializeDateFormatting('id-ID');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'D-Wallet',
      theme: AppTheme.appTheme,
      routerConfig: AppRoute().route,
    );
  }
}
