import 'package:dbank/viewmodels/auth/insert_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InsertPasswordView extends StatefulWidget {
  const InsertPasswordView({super.key});

  @override
  State<InsertPasswordView> createState() => _InsertPasswordViewState();
}

class _InsertPasswordViewState extends State<InsertPasswordView> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(int index, String value, InsertPasswordViewModel viewModel) {
    // Get current controllers' values to build the PIN
    String newPin = '';
    
    if (value.isNotEmpty) {
      // Set the new value in the controller
      _controllers[index].text = value;
      
      // Build PIN from all controllers
      for (int i = 0; i < 6; i++) {
        if (_controllers[i].text.isNotEmpty) {
          newPin += _controllers[i].text;
        }
      }
      
      viewModel.updatePin(newPin);
      
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      // Clear the controller and rebuild PIN
      _controllers[index].clear();
      
      for (int i = 0; i < 6; i++) {
        if (_controllers[i].text.isNotEmpty) {
          newPin += _controllers[i].text;
        }
      }
      
      viewModel.updatePin(newPin);
      
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

Widget _buildPinField(int index, InsertPasswordViewModel viewModel) {
  bool isFilled = _controllers[index].text.isNotEmpty;
  
  return Container(
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      shape: BoxShape.circle,
      color: isFilled ? Colors.black : Colors.transparent,
    ),
    child: TextField(
      controller: _controllers[index],
      focusNode: _focusNodes[index],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      obscureText: true,
      cursorColor: Colors.transparent,
      showCursor: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(
        fontSize: 24, 
        fontWeight: FontWeight.bold,
        color: Colors.transparent,
      ),
      onChanged: (value) => _onPinChanged(index, value, viewModel),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InsertPasswordViewModel(),
      child: Consumer<InsertPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Masukkan Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) => _buildPinField(index, viewModel)),
                  ),
                  const SizedBox(height: 32),
                  if (viewModel.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}