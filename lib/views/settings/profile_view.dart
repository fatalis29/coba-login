import 'package:dbank/viewmodels/settings/profile_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
                    leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
        ),
      body: ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => ProfileViewModel(),
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            // Loading status
            if (viewModel.status == UIModelStatus.Loading) {
              return const Center(
                  child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            }
            // Error Status
            // Ended Status
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text('Profile Merchant', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(height: 4),
                Divider(height: 2, color: Theme.of(context).colorScheme.background),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PROFIL MERCHANT Section
                      _buildSectionHeader('PROFIL MERCHANT'),
                      const SizedBox(height: 24),
                      
                      _buildField('Merchant ID', '0000537309'),
                      const SizedBox(height: 20),
                      
                      _buildField('Nama Merchant', 'Toko Tiga Lebih'),
                      const SizedBox(height: 20),
                      
                      _buildField('Alamat', 'Jl. Kedoya no.1, Kedoya Selatan, Kebon Jeruk, Jakarta Barat, 11520'),
                      const SizedBox(height: 20),
                      
                      _buildField('Email', 'hi.tokotrigalebih@gmail.com'),
                      const SizedBox(height: 32),
                      
                      // PENANGGUNG JAWAB Section
                      _buildSectionHeader('PENANGGUNG JAWAB'),
                      const SizedBox(height: 24),
                      
                      _buildField('Nama', 'Monica Putri'),
                      const SizedBox(height: 20),
                      
                      _buildField('No. Ponsel', '081220944627'),
                      const SizedBox(height: 20),
                      
                      _buildField('NIK', '1202144194'),
                      const SizedBox(height: 32),
                      
                      // REKENING BANK Section
                      _buildSectionHeader('REKENING BANK'),
                      const SizedBox(height: 24),
                      
                      _buildField('Nama Bank', 'Bank Syariah Indonesia'),
                      const SizedBox(height: 20),
                      
                      _buildField('No. Rekening', '7541202144194'),
                      const SizedBox(height: 20),
                      
                      _buildField('Nama Pemilik Rekening', 'Monica Putri'),
                    ],
                  ),
                ),
              ],
            );
          }
        )
      )
    );
  }
  

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}