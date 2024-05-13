class Validation {
  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }
    return null;
  }

  static String? validatePanNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pan number is required';
    }

    RegExp panRegex = RegExp(r'^[0-9]{9}$');
    if (!panRegex.hasMatch(value)) {
      return 'Enter a valid Pan number';
    }

    return null;
  }

  static String? validateRegistrationDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Registration date is required';
    }

    // Assuming a simple date format validation for illustration
    RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Enter a valid date in the format YYYY-MM-DD';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Password should have at least 8 characters, including one uppercase letter, one lowercase letter, and one digit
    RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must have at least 8 characters with one uppercase letter and one digit';
    }
    return null;
  }

  static String? validateRetypedPassword(String? password, String? retypedPassword) {
    if (retypedPassword == null || retypedPassword.isEmpty) {
      return 'Retype password is required';
    }
    if (password != retypedPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }

    // Assuming a simple validation for a 10-digit phone number
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit contact number';
    }

    return null;
  }
}

