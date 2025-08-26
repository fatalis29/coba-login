import 'package:dbank/viewmodels/settings/changepin_viewmodel.dart';
import 'package:dbank/views/components/appbar_title_text.dart';
import 'package:dbank/views/components/forms.dart';
import 'package:dbank/views/components/route_debug_view.dart';
import 'package:dbank/views/components/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChangePinView extends StatefulWidget {
  const ChangePinView({super.key});

  @override
  State<ChangePinView> createState() => _ChangePinViewState();
}

class _ChangePinViewState extends State<ChangePinView> {
  bool _hiddenOldPin = true;
  bool _hiddenNewPin = true;
  bool _hiddenConfirmsNewPin = true;

  // Form key to manage form state (e.g., for validation)
  final _formKey = GlobalKey<FormState>();

  // Toggles visibility for the "current password" field
  void _toggleOldPinVisibility() {
    setState(() {
      _hiddenOldPin = !_hiddenOldPin;
    });
  }

  // Toggles visibility for the "new password" field
  void _toggleNewPinVisibility() {
    setState(() {
      _hiddenNewPin = !_hiddenNewPin;
    });
  }

  // Toggles visibility for the "confirm new password" field
  void _toggleConfirmPinVisibility() {
    setState(() {
      _hiddenConfirmsNewPin = !_hiddenConfirmsNewPin;
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
      body: ChangeNotifierProvider<ChangePinViewModel>(
        create: (context) => ChangePinViewModel(),
        child: Consumer<ChangePinViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Text('Ubah Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                const SizedBox(height: 4),
                  Form(
                    child: Column(
                      children: [
              const SizedBox(height: 20),
              // --- Usage Example ---
              // Here we use the new StyledFormFieldItem.
              // Note how `fieldTitle` is now `hintText`.

              StyledFormFieldItem(
                hintText: 'Password saat ini',
                inputType: TextInputType.number,
                maxLength: 6,
                isObscured: _hiddenOldPin,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    _hiddenOldPin ? 'assets/icon/eye-off.svg' : 'assets/icon/eye.svg',
                    color: Theme.of(context).shadowColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _toggleOldPinVisibility,
                ),
                onChanged: (value) {
                  viewModel.setOldPin(value);
                },
              ),
              StyledFormFieldItem(
                hintText: 'Buat password baru',
                inputType: TextInputType.number,
                maxLength: 6,
                isObscured: _hiddenNewPin,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    _hiddenNewPin ? 'assets/icon/eye-off.svg' : 'assets/icon/eye.svg',
                    color: Theme.of(context).shadowColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _toggleNewPinVisibility,
                ),
                onChanged: (value) {
                  viewModel.setPin(value);
                },
              ),
              StyledFormFieldItem(
                hintText: 'Konfirmasi password baru',
                inputType: TextInputType.number,
                maxLength: 6,
                isObscured: _hiddenConfirmsNewPin,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    _hiddenConfirmsNewPin ? 'assets/icon/eye-off.svg' : 'assets/icon/eye.svg',
                    color: Theme.of(context).shadowColor,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _toggleConfirmPinVisibility,
                ),
                onChanged: (value) {
                  viewModel.setConfirmsNewPin(value);
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
                      onPressed: () => viewModel.submitLoginInfo(), 
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