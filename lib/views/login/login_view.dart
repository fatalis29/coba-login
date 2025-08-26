import 'package:dbank/models/ui_model_status.dart';
import 'package:dbank/routes/routes.dart';
import 'package:dbank/views/components/forms.dart';
import 'package:dbank/views/components/clickable_text.dart';
import 'package:dbank/views/components/show_exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dbank/viewmodels/login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showExitDialog(context); //TODO: fix this
      },
      child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: ChangeNotifierProvider<LoginViewModel>(
                create: (context) => LoginViewModel(),
                child: Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 64.0),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: SvgPicture.asset('assets/logo-new.svg', height: 128, semanticsLabel: 'D-Wallet Logo'),
                        ),
                        const SizedBox(height: 64.0),
                        Form(
                          key: viewModel.loginFormKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              FormFieldItem(
                                fieldTitle: 'Merchant ID', 
                                inputType: TextInputType.number,
                                maxLength: 10,
                                hintText: '0000000XXX',
                                validationText: 'Tolong masukkan Merchant ID',
                                enabled: viewModel.status == UIModelStatus.Ended,
                                onChanged: (value) {
                                  viewModel.setMerchantId(value);
                                },
                              ),
                              !viewModel.withTerminalId ? const SizedBox(height: 0, width: 0) : 
                              FormFieldItem(
                                fieldTitle: 'Terminal ID', 
                                inputType: TextInputType.number,
                                maxLength: 10,
                                hintText: '0000000XXX',
                                validationText: 'Tolong masukkan Terminal ID',
                                enabled: viewModel.status == UIModelStatus.Ended,
                                onChanged: (value) {
                                  viewModel.setTerminalId(value);
                                },
                              ),
                              FormFieldItem(
                                fieldTitle: 'Password',
                                inputType: TextInputType.number,
                                maxLength: 6,
                                hintText: '123456',
                                isObscured: viewModel.hiddenPin,
                                validationText: 'Tolong masukkan PIN',
                                visibleCounter: true,
                                enabled: viewModel.status == UIModelStatus.Ended,
                                suffixIcon:  IconButton(
                                  alignment: Alignment.centerRight,
                                  iconSize: 20,
                                  icon: Icon(
                                    viewModel.hiddenPin
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                    color: Theme.of(context).shadowColor,
                                  ),
                                    onPressed: () {
                                      viewModel.toggleVisibility();
                                  },
                                ),
                                onChanged: (newPin) {
                                  viewModel.setPin(newPin);
                                },
                              ),
                            ]
                          )
                        ),
                        const SizedBox(height: 24),
                        ClickableText(
                          linkText: 'Lupa Password?',
                          onPressed: () {
                            context.pushNamed(Routes.lupaPassword.routeName);
                          }
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: FilledButton(
                            onPressed: () {
                              viewModel.submitLoginInfo().then((loginSuccess) {
                                if (loginSuccess) {
                                  context.goNamed(Routes.dashboard.routeName);
                                }
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.amber[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6), // Lower roundedness
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: viewModel.status == UIModelStatus.Ended
                                  ? const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )
                                  : SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator.adaptive(
                                        valueColor: AlwaysStoppedAnimation(Colors.teal[700]),
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        ClickableText(
                          linkText: viewModel.withTerminalId ? "Login dengan Merchant ID" : "Login dengan Terminal ID",
                          onPressed: () {
                            viewModel.toggleTerminalId();
                          }
                        ),
                        const Text('ver. 1.0.0.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),)
                        // TODO: Check the actual version
                      ],
                    );
                  },
                ),
              ),
            )
          )
        ),
    );
  }
}