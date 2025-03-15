import 'payment_method.dart';

class CashOnDeliveryPayment implements PaymentMethod {
  @override
  String get methodName => "Cash on Delivery";

  @override
  Map<String, dynamic> toJson() {
    return {"method": methodName};
  }
}
