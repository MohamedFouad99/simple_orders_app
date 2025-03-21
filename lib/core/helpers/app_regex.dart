//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that contains regular expressions used in the application.
class AppRegex {
  static bool isPhoneNumberValid(String phoneNumber) {
    // Matches a phone number that starts with 5 and has exactly 8 digits
    return RegExp(r'^5\d{8}$').hasMatch(phoneNumber);
  }
}
