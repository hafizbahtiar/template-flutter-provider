import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_provider/core/navigation/routes_name.dart';
import 'package:template_flutter_provider/features/auth/providers/sign_in_provider.dart';
import 'package:template_flutter_provider/features/common/providers/preference_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/language_selector.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final preferenceProvider = context.watch<PreferenceProvider>();

    return ChangeNotifierProvider(
      create: (_) => SignInProvider(),
      child: Consumer<SignInProvider>(
        builder: (context, signInProvider, _) {
          return Scaffold(
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LanguageSelector(
                        currentLocale: preferenceProvider.currentLocale.toString(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            preferenceProvider.changeLanguage(newValue);
                          }
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      SignInForm(
                        signInProvider: signInProvider,
                        onSignInSuccess: () {
                          Navigator.pushReplacementNamed(context, RoutesName.home);
                        },
                        onRegisterPressed: () {
                          if (signInProvider.isLoading) return;
                          Navigator.pushNamed(context, RoutesName.signUp);
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
