import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cash_on_delivery_payment.dart';
import '../../data/model/credit_card_payment.dart';
import '../../data/model/pay_later_payment.dart';
import '../../data/model/payment_method.dart';

part 'order_state.dart';
//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a cubit for the order feature.

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  /// Updates the customer information in the order state.
  ///
  /// [name] is the name of the customer.
  /// [phone] is the phone number of the customer.
  /// [address] is the address of the customer.
  ///
  void updateCustomerInfo({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(state.copyWith(name: name, phone: phone, address: address));
  }

  /// Updates the package details in the order state.
  ///
  /// [packageType] is the type of package.
  /// [weight] is the weight of the package in kilograms.
  /// [notes] are any additional notes related to the package.

  void updatePackageDetails({
    required String packageType,
    required double weight,
    String? notes,
  }) {
    emit(
      state.copyWith(packageType: packageType, weight: weight, notes: notes),
    );
  }

  /// Selects a payment method for the order.
  ///
  /// [method] is the name of the payment method. Valid values are "Credit Card",
  /// "Pay Later", and "Cash on Delivery". This method updates the order state
  /// by setting the [paymentMethod] to the selected payment method, and
  /// setting the [paymentMethod] to [CreditCardPayment] if the selected
  /// payment method is "Credit Card", to [PayLaterPayment] if the selected
  /// payment method is "Pay Later", and to [CashOnDeliveryPayment] if the
  /// selected payment method is "Cash on Delivery".
  void selectPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: _createPaymentMethod(method)));
  }

  /// Creates a payment method based on the provided [method] string.
  ///
  /// Returns a [CreditCardPayment] if [method] is "Credit Card", a [PayLaterPayment]
  /// if [method] is "Pay Later", and a [CashOnDeliveryPayment] if [method] is
  /// "Cash on Delivery".
  PaymentMethod _createPaymentMethod(String method) {
    if (method == "Credit Card") {
      return CreditCardPayment(cardNumber: '');
    } else if (method == "Pay Later") {
      return PayLaterPayment(phoneNumber: '');
    } else {
      return CashOnDeliveryPayment();
    }
  }

  /// Updates the payment method in the order state.
  ///
  /// [paymentMethod] is the new payment method to be set for the order.
  /// This method emits a new state with the updated payment method.

  void updatePaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  /// Submits the order.
  ///
  /// This method emits the [OrderSubmitting] state, and then after a delay of 2
  /// seconds, emits the [OrderSubmitted] state with the current state of the
  /// order.
  void submitOrder() {
    emit(OrderSubmitting());
    Future.delayed(const Duration(seconds: 2), () {
      emit(OrderSubmitted(state));
    });
  }
}
