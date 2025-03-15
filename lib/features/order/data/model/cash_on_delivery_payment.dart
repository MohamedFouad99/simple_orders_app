import 'payment_method.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a cash on delivery payment method.
class CashOnDeliveryPayment implements PaymentMethod {
  @override
  String get methodName => "Cash on Delivery";

  @override
  Map<String, dynamic> toJson() {
    return {"method": methodName};
  }
}
