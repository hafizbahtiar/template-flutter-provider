import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_provider/core/navigation/routes_name.dart';
import 'package:template_flutter_provider/features/auth/providers/sign_up_provider.dart';
import 'package:template_flutter_provider/features/auth/widgets/sign_up_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Consumer<SignUpProvider>(
        builder: (context, signUpProvider, _) {
          return Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.signUp), elevation: 0, centerTitle: false),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.createAccount,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.fillDetailsBelow,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      SignUpForm(
                        signUpProvider: signUpProvider,
                        onRegisterSuccess: () {
                          // Navigate to sign-in screen or verification screen after registration
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.registrationSuccessful),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pushReplacementNamed(context, RoutesName.signIn);
                        },
                        onSignInPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
