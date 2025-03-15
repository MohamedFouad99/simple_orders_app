import 'payment_method.dart';

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
