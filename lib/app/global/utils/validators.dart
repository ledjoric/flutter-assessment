class Validator {
  static String? validateName(String? value, String? asyncError) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    if (asyncError != null) {
      return asyncError;
    }

    return null;
  }

  static String? validateEmailSignUp(String? value, String? asyncError) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (asyncError != null) {
      return asyncError;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value, String? asyncError) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (asyncError != null) {
      return asyncError;
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validateText(String? value, String emptyErrorText) {
    if (value == null || value.isEmpty) {
      return emptyErrorText;
    }

    return null;
  }
}
