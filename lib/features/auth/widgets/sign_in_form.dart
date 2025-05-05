import 'package:flutter/material.dart';
import 'package:template_flutter_provider/core/utils/validators.dart';
import 'package:template_flutter_provider/features/auth/providers/sign_in_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInForm extends StatefulWidget {
  final SignInProvider signInProvider;
  final VoidCallback onSignInSuccess;
  final VoidCallback onRegisterPressed;

  const SignInForm({
    super.key,
    required this.signInProvider,
    required this.onSignInSuccess,
    required this.onRegisterPressed,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 5),
          _buildRememberMeAndForgotPassword(),
          _buildErrorMessage(),
          const SizedBox(height: 20),
          _buildSignInButton(),
          const SizedBox(height: 16),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      enabled: widget.signInProvider.isLoading == false,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validators.validateEmail(value, context),
      onChanged: (_) => widget.signInProvider.resetError(),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      enabled: widget.signInProvider.isLoading == false,
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(widget.signInProvider.obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () => widget.signInProvider.togglePasswordVisibility(),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      obscureText: widget.signInProvider.obscurePassword,
      validator: (value) => Validators.validatePassword(value, context),
      onChanged: (_) => widget.signInProvider.resetError(),
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: widget.signInProvider.rememberMe,
            onChanged: (value) {
              if (widget.signInProvider.isLoading) return;
              widget.signInProvider.toggleRememberMe(value ?? true);
            },
          ),
        ),
        const SizedBox(width: 8),
        Text(AppLocalizations.of(context)!.rememberMe),
        const Spacer(),
        TextButton(
          onPressed: () => _showForgotPasswordDialog(),
          child: Text(AppLocalizations.of(context)!.forgotPassword),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    if (widget.signInProvider.errorMessage.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        widget.signInProvider.errorMessage,
        style: TextStyle(color: Colors.red.shade800),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: widget.signInProvider.isLoading ? null : _signIn,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child:
          widget.signInProvider.isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
              : Text(
                AppLocalizations.of(context)!.signIn,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
    );
  }

  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: widget.onRegisterPressed,
      child: Text("${AppLocalizations.of(context)!.dontHaveAccount} ${AppLocalizations.of(context)!.signUp}"),
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await widget.signInProvider.signIn(_emailController.text.trim(), _passwordController.text);

    if (success && mounted) {
      widget.onSignInSuccess();
    }
  }

  void _showForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();
    bool isSubmitting = false;

    if (widget.signInProvider.isLoading) return;

    if (_emailController.text.isNotEmpty) {
      emailController.text = _emailController.text;
    }

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.resetPassword),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(context)!.enterEmailForReset),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    ),
                    FilledButton(
                      onPressed:
                          isSubmitting
                              ? null
                              : () async {
                                if (emailController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppLocalizations.of(context)!.pleaseEnterEmail),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                setDialogState(() {
                                  isSubmitting = true;
                                });

                                final success = await widget.signInProvider.requestPasswordReset(
                                  emailController.text.trim(),
                                );

                                if (success && context.mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppLocalizations.of(context)!.resetEmailSent),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else if (context.mounted) {
                                  setDialogState(() {
                                    isSubmitting = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Reset Email Error'), backgroundColor: Colors.red),
                                  );
                                }
                              },
                      child:
                          isSubmitting
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : Text(AppLocalizations.of(context)!.sendResetLink),
                    ),
                  ],
                ),
          ),
    );
  }
}
