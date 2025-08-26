import 'package:dbank/routes/routes.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; // Add this import for ImageFilter
import 'package:go_router/go_router.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text('Pengaturan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            const SizedBox(height: 4),
            Divider(height: 2, color: Theme.of(context).colorScheme.background),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  SettingsButton(
                    icon: Icons.home_filled,
                    text: 'Profil Merchant',
                    onTap: () {
                      context.pushNamed(Routes.profil.routeName);
                    },
                  ),
                  Divider(height: 16, color: Theme.of(context).colorScheme.background),
                  SettingsButton(
                    icon: Icons.key,
                    text: 'Ubah Password',
                    onTap: () {
                      context.pushNamed(Routes.ubahPin.routeName);
                    },
                  ),
                  Divider(height: 16, color: Theme.of(context).colorScheme.background),
                  SettingsButton(
                    icon: Icons.logout,
                    text: 'Log Out',
                    onTap: () {
                      _showLogoutBottomSheet(context);
                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              
              // Heading
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Apakah kamu yakin untuk\nkeluar dari BSI Merchant?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Sub heading
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Setelah keluar, kamu harus masuk kembali\nuntuk dapat menggunakan fitur BSI Merchant.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Buttons
              Center(
                child: Column(
                  children: [
                    // Logout button (outlined)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Add your logout logic here
                          // Example: context.goNamed(Routes.login.routeName);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFE6A623), // Orange/yellow border
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Keluar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE6A623), // Orange/yellow text
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Cancel button (filled)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6A623), // Orange/yellow background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Batalkan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom padding for safe area
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

}

// context.pushNamed(Routes.profil.routeName);

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const SettingsButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24.0,
                  color: iconColor ?? Colors.grey.shade700,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? Colors.black,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 24.0,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}