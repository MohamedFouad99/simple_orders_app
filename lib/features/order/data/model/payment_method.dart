//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create an abstract class that represents a payment method.
abstract class PaymentMethod {
  String get methodName;
  Map<String, dynamic> toJson(); // Converts payment details to JSON
}
