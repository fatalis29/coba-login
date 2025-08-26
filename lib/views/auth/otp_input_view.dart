import 'package:dbank/routes/routes.dart';
import 'package:dbank/viewmodels/auth/otp_input_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OTPInputView extends StatelessWidget {
  const OTPInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OTPInputViewModel(),
      child: Consumer<OTPInputViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Masukkan OTP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Masukkan 4 digit kode OTP yang telah dikirim ke ${hideMerchantId(viewModel.merchantId)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Custom OTP Input Field
                  OTPInputWidget(
                    onChanged: (otp) {
                      viewModel.setOTP(otp);
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Conditionally show "Kirim Ulang OTP" button
                  if (viewModel.otp.length == 4)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: viewModel.isLoading ? null : () async {
                          await viewModel.resendOTP();
                          if (viewModel.errorMessage.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('OTP telah dikirim ulang'),
                                backgroundColor: Color(0xFFE6A623),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Kirim Ulang OTP',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  
                  // Show error message if any
                  if (viewModel.errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        viewModel.errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  
                  const Spacer(),
                  
                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: viewModel.isButtonEnabled 
                            ? const Color(0xFFE6A623) 
                            : Colors.grey[400],
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: viewModel.isButtonEnabled 
                          ? () async {
                              await viewModel.verifyOTP();
                              
                              // Handle success case
                              if (viewModel.errorMessage.isEmpty && !viewModel.isLoading) {
                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('OTP berhasil diverifikasi'),
                                    backgroundColor: Color(0xFFE6A623),
                                  ),
                                );
                                
                                // Navigate to next step or login
                                context.pushNamed(Routes.login.routeName);
                              }
                            }
                          : null,
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Verifikasi',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OTPInputWidget extends StatefulWidget {
  final Function(String) onChanged;
  final String? label;

  const OTPInputWidget({
    super.key,
    required this.onChanged,
    this.label = "THG",
  });

  @override
  State<OTPInputWidget> createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

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

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not the last one
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, unfocus
        _focusNodes[index].unfocus();
      }
    }
    // Collect all digits and notify parent
    String otp = _controllers.map((controller) => controller.text).join();
    widget.onChanged(otp);
  }

  void _onBackspace(int index) {
    if (index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      // Update OTP
      String otp = _controllers.map((controller) => controller.text).join();
      widget.onChanged(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Label on the left
            if (widget.label != null)
              Container(
                width: 80,
                child: Text(
                  widget.label!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            // OTP input fields
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _onChanged(value, index);
                        }
                      },
                      onTap: () {
                        // Clear the field when tapped
                        _controllers[index].clear();
                        String otp = _controllers.map((controller) => controller.text).join();
                        widget.onChanged(otp);
                      },
                      decoration: InputDecoration(
                        counterText: '', // Hide character counter
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange.shade400,
                            width: 3,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange.shade400,
                            width: 3,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange.shade600,
                            width: 3,
                          ),
                        ),
                        fillColor: Colors.transparent,
                        filled: false,
                        contentPadding: const EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

String hideMerchantId(String merchantId) {
  if (merchantId.length <= 4) {
    return merchantId; // No hiding needed for short IDs
  }
  return '${merchantId.substring(0, 2)}****${merchantId.substring(merchantId.length - 2)}';
}