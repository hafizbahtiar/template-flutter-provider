import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_provider/core/utils/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template_flutter_provider/features/auth/providers/sign_up_provider.dart';

class SignUpForm extends StatefulWidget {
  final SignUpProvider signUpProvider;
  final VoidCallback onRegisterSuccess;
  final VoidCallback onSignInPressed;

  const SignUpForm({
    super.key,
    required this.signUpProvider,
    required this.onRegisterSuccess,
    required this.onSignInPressed,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFirstNameField(),
          const SizedBox(height: 20),
          _buildLastNameField(),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildConfirmPasswordField(),
          const SizedBox(height: 16),
          _buildTermsAgreement(),
          _buildErrorMessage(),
          const SizedBox(height: 24),
          _buildRegisterButton(),
          const SizedBox(height: 16),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.firstName,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      validator: (value) => Validators.validateFirstName(value, context),
      onChanged: (_) => widget.signUpProvider.resetError(),
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.lastName,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      validator: (value) => Validators.validateLastName(value, context),
      onChanged: (_) => widget.signUpProvider.resetError(),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.validateEmail(value, context),
      onChanged: (_) => widget.signUpProvider.resetError(),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(widget.signUpProvider.obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => widget.signUpProvider.togglePasswordVisibility(),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      obscureText: widget.signUpProvider.obscurePassword,
      validator: (value) => Validators.validatePassword(value, context),
      onChanged: (_) => widget.signUpProvider.resetError(),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.confirmPassword,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.lock_outline),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      obscureText: true,
      validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text, context),
      onChanged: (_) => widget.signUpProvider.resetError(),
    );
  }

  Widget _buildTermsAgreement() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: widget.signUpProvider.agreeToTerms,
            onChanged: (value) => widget.signUpProvider.toggleTermsAgreement(value ?? false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
              children: [
                TextSpan(text: AppLocalizations.of(context)!.iAgreeToThe),
                TextSpan(
                  text: ' ${AppLocalizations.of(context)!.termOfService} ',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Terms of Service
                        },
                ),
                TextSpan(text: AppLocalizations.of(context)!.and),
                TextSpan(
                  text: ' ${AppLocalizations.of(context)!.privacyPolicy}',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Privacy Policy
                        },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    if (widget.signUpProvider.errorMessage.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        widget.signUpProvider.errorMessage,
        style: TextStyle(color: Colors.red.shade800),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: widget.signUpProvider.isLoading ? null : _signUp,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          widget.signUpProvider.isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
              : Text(
                AppLocalizations.of(context)!.signUp,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
    );
  }

  Widget _buildSignInButton() {
    return TextButton(
      onPressed: widget.onSignInPressed,
      child: Text("${AppLocalizations.of(context)!.alreadyHaveAccount} ${AppLocalizations.of(context)!.signIn}"),
    );
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (!widget.signUpProvider.agreeToTerms) {
      widget.signUpProvider.setErrorMessage(AppLocalizations.of(context)!.mustAgreeToTerms);
      return;
    }

    final success = await widget.signUpProvider.signUp(
      name: _firstNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      widget.onRegisterSuccess();
    }
  }
}
