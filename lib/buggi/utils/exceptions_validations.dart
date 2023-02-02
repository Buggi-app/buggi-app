String? emptyValidation(dynamic value) {
  if (value!.isEmpty) {
    return 'Field cannot be empty';
  }
  return null;
}

String? emailValidation(String? value) {
  if (value!.isEmpty || !value.contains('@')) {
    return 'Please enter a valid email';
  }
  if (value.length < 6) {
    return 'Please enter a valid email';
  }
  if (value.isNotEmpty) {
    if (value.length > 5 &&
        !(value.substring(value.length - 4, value.length - 2).contains('.'))) {
      return 'Please enter a valid email';
    }
  }
  return null;
}

String? passwordValidation(dynamic password) {
  final bool isLengthOk = password.length >= 8;
  final bool isNumeric = password.contains(RegExp('[0-9]'));
  final bool isLowerCase = password.contains(RegExp("(?:[^a-z]*[a-z]){1}"));
  final bool isUpperCase = password.contains(RegExp("(?:[^A-Z]*[A-Z]){1}"));
  if (!isLengthOk || !isNumeric || !isLowerCase || !isUpperCase) {
    return 'Password must have at least 8 characters, a number, lowercase and uppercase letters';
  }
  return null;
}
