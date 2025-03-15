import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cash_on_delivery_payment.dart';
import '../../data/model/credit_card_payment.dart';
import '../../data/model/pay_later_payment.dart';
import '../../data/model/payment_method.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void updateCustomerInfo({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(state.copyWith(name: name, phone: phone, address: address));
  }

  void updatePackageDetails({
    required String packageType,
    required double weight,
    String? notes,
  }) {
    emit(
      state.copyWith(packageType: packageType, weight: weight, notes: notes),
    );
  }

  void selectPaymentMethod(String method) {
    emit(state.copyWith(paymentMethod: _createPaymentMethod(method)));
  }

  PaymentMethod _createPaymentMethod(String method) {
    if (method == "Credit Card") {
      return CreditCardPayment(cardNumber: '');
    } else if (method == "Pay Later") {
      return PayLaterPayment(phoneNumber: '');
    } else {
      return CashOnDeliveryPayment();
    }
  }

  void updatePaymentMethod(PaymentMethod paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  void submitOrder() {
    emit(OrderSubmitting());
    Future.delayed(const Duration(seconds: 2), () {
      emit(OrderSubmitted(state));
    });
  }
}
