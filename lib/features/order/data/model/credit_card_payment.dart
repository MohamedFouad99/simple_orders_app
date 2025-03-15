import 'payment_method.dart';

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
