import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/settings/changepassword_viewmodel.dart';
import 'package:dbank/views/components/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool _hiddenOldPassword = true;
  bool _hiddenNewPassword = true;
  bool _hiddenConfirmPassword = true;

  // Toggles visibility for the "old password" field
  void _toggleOldPasswordVisibility() {
    setState(() {
      _hiddenOldPassword = !_hiddenOldPassword;
    });
  }

  // Toggles visibility for the "new password" field
  void _toggleNewPasswordVisibility() {
    setState(() {
      _hiddenNewPassword = !_hiddenNewPassword;
    });
  }

  // Toggles visibility for the "confirm password" field
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _hiddenConfirmPassword = !_hiddenConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: true,
          shadowColor: Theme.of(context).colorScheme.shadow,
                    leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () => context.pop()),
      ),
      body: ChangeNotifierProvider<ChangePasswordViewModel>(
        create: (context) => ChangePasswordViewModel(),
        child: Consumer<ChangePasswordViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 2),
                  child: const Text(
                    'Ubah Password', 
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.black
                    )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Masukkan 6 digit password',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                    child: Column(
                      children: [
              StyledFormFieldItem(
                hintText: 'Buat password baru',
                inputType: TextInputType.number,
                maxLength: 6,
                isObscured: _hiddenNewPassword,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    _hiddenNewPassword ? 'assets/icon/eye-off.svg' : 'assets/icon/eye.svg',
                    color: Theme.of(context).shadowColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _toggleNewPasswordVisibility,
                ),
                onChanged: (value) {
                  viewModel.setNewPassword(value);
                },
              ),
              StyledFormFieldItem(
                hintText: 'Konfirmasi password baru',
                inputType: TextInputType.number,
                maxLength: 6,
                isObscured: _hiddenConfirmPassword,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    _hiddenConfirmPassword ? 'assets/icon/eye-off.svg' : 'assets/icon/eye.svg',
                    color: Theme.of(context).shadowColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
                onChanged: (value) {
                  viewModel.setConfirmPassword(value);
                },
              ),
                      ],
                    )
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.amber[500],
                        foregroundColor: Colors.black87,
                      ),
                      onPressed: () => viewModel.submitPasswordInfo(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: viewModel.status == UIModelStatus.Ended ?
                          const Text('Ubah Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) :
                          SizedBox(height: 20, width: 20,child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.onPrimary)))
                      )
                    ),
                  ),
                  //DevPageNavigator(),
                ],
              ),
            );
          }
        )
      )
    );
  }
}