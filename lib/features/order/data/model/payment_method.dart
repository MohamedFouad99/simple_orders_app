abstract class PaymentMethod {
  String get methodName;
  Map<String, dynamic> toJson(); // Converts payment details to JSON
}
