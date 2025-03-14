import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void updatePaymentMethod({
    required String method,
    String? cardNumber,
    String? phone,
  }) {
    emit(
      state.copyWith(
        paymentMethod: method,
        cardNumber: cardNumber,
        phone: phone,
      ),
    );
  }

  void submitOrder() {
    emit(OrderSubmitting());
    Future.delayed(const Duration(seconds: 2), () {
      emit(OrderSubmitted(state));
    });
  }
}
