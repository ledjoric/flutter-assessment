import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/app/data/services/auth_services.dart';
import 'package:flutter_assessment/app/global/constants/app_constants.dart';
import 'package:flutter_assessment/app/global/utils/toast_util.dart';
import 'package:flutter_assessment/app/models/auth.dart';
import 'package:flutter_assessment/app/routes/route_names.dart';
import 'package:flutter_assessment/app/global/utils/validators.dart';
import 'package:flutter_assessment/app/singleton/secure_storage_singleton.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _loginErrorMessage = '';
  final bool _isLoginError = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final storedToken = await SecureStorageSingleton.read('oauth');
      if (storedToken != null) {
        if (context.mounted) context.go(homeScreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  alignment: Alignment.center,
                  decoration: !isWideScreen
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                  padding: !isWideScreen ? null : const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: AppConstants.textFieldDecoration(label: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => Validator.validateEmail(value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          decoration: AppConstants.textFieldDecoration(label: 'Password'),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) => Validator.validateText(value, 'Please enter your password'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 125),
                          child: _isLoginError
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    _loginErrorMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.maxFinite,
                          child: FilledButton(
                            style: AppConstants.filledButtonStyle(),
                            onPressed: _isLoading ? null : login,
                            child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.maxFinite,
                          child: OutlinedButton(
                            style: AppConstants.filledButtonStyle(),
                            onPressed: _isLoading ? null : () => GoRouter.of(context).push(signupScreen),
                            child: const Text('Signup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final response = await AuthService.login(
        Auth(
          username: _emailController.text,
          password: _passwordController.text,
        ),
      );
      setState(() => _isLoading = true);

      if (response['message'] == null) {
        if (context.mounted) GoRouter.of(context).go(homeScreen);
      } else {
        if (context.mounted) ToastUtil.showToast(context, response['message']);
      }
    }
  }
}
