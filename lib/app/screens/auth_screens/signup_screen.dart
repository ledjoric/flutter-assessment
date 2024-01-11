import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/data/services/auth_services.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/models/signup_data.dart';
import 'package:flutter_assessment/app/providers/theme_provider.dart';
import 'package:flutter_assessment/app/routes/route_names.dart';
import 'package:flutter_assessment/app/global/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../global/utils/toast_util.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: isWideScreen
          ? null
          : AppBar(
              title: const Text(
                'Sign up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                surfaceTintColor: Colors.transparent,
                shadowColor: !isWideScreen ? Colors.transparent : null,
                margin: EdgeInsets.zero,
                color: !isWideScreen ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).canvasColor,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: !isWideScreen
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                  padding: !isWideScreen ? null : const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isWideScreen) ...[
                          const Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16)
                        ],
                        TextFormField(
                          controller: _usernameController,
                          decoration: AppConstants.textFieldDecoration(label: 'Username'),
                          validator: (value) => Validator.validateName(value, _nameError),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => setState(() => _nameError = null),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: AppConstants.textFieldDecoration(label: 'Email'),
                          validator: (value) => Validator.validateEmailSignUp(value, _emailError),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => setState(() => _emailError = null),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          decoration: AppConstants.textFieldDecoration(label: 'Password'),
                          validator: (value) => Validator.validatePassword(value, _passwordError),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => setState(() => _passwordError = null),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.maxFinite,
                          child: FilledButton(
                            style: AppConstants.filledButtonStyle(),
                            onPressed: _isLoading ? null : signup,
                            child: Text('Sign Up', style: AppConstants.titleTextStyle(fontsize: 16)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<ThemeProvider>(
                          builder: (context, provider, child) => RichText(
                            text: TextSpan(
                              style: TextStyle(color: provider.isDarkMode ? Colors.white : Colors.black),
                              children: <TextSpan>[
                                const TextSpan(text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Login',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _isLoading ? null : () => context.go(loginScreen),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await AuthService.signup(
        SignUpData(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      ).then((response) {
        setState(() => _isLoading = false);
        if (response['data'] != null) {
          if (context.mounted) ToastUtil.showToast(context, response['data']['message']);
          if (context.mounted) GoRouter.of(context).go(loginScreen);
        } else if (response['error'] != null) {
          if (response['error']['name'] != null) _nameError = response['error']['name'][0];
          if (response['error']['email'] != null) _emailError = response['error']['email'][0];
          if (response['error']['password'] != null) _passwordError = response['error']['password'][0];
        } else {
          if (context.mounted) ToastUtil.showToast(context, response['message']);
        }
      });
      setState(() => _isLoading = false);
    }
  }
}
