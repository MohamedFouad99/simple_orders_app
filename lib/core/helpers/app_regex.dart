class AppRegex {
  static bool isPhoneNumberValid(String phoneNumber) {
    // Matches a phone number that starts with 5 and has exactly 8 digits
    return RegExp(r'^5\d{8}$').hasMatch(phoneNumber);
  }
}
