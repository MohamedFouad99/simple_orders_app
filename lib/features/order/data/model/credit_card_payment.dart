import 'payment_method.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a credit card payment method.
class CreditCardPayment implements PaymentMethod {
  final String cardNumber;

  CreditCardPayment({required this.cardNumber});

  @override
  String get methodName => "Credit Card";

  @override
  Map<String, dynamic> toJson() {
    return {"method": methodName, "cardNumber": cardNumber};
  }
}
