import 'payment_method.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a pay later payment method.
class PayLaterPayment implements PaymentMethod {
  final String phoneNumber;

  PayLaterPayment({required this.phoneNumber});

  @override
  String get methodName => "Pay Later";

  @override
  Map<String, dynamic> toJson() {
    return {"method": methodName, "phoneNumber": phoneNumber};
  }
}
