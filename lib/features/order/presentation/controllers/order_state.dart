part of 'order_cubit.dart';

class OrderState extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String packageType;
  final double weight;
  final String? notes;
  final PaymentMethod? paymentMethod;

  const OrderState({
    this.name = '',
    this.phone = '',
    this.address = '',
    this.packageType = '',
    this.weight = 0.0,
    this.notes,
    this.paymentMethod,
  });

  OrderState copyWith({
    String? name,
    String? phone,
    String? address,
    String? packageType,
    double? weight,
    String? notes,
    PaymentMethod? paymentMethod,
  }) {
    return OrderState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      packageType: packageType ?? this.packageType,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    name,
    phone,
    address,
    packageType,
    weight,
    notes,
    paymentMethod,
  ];
}

class OrderInitial extends OrderState {}

class OrderSubmitting extends OrderState {}

class OrderSubmitted extends OrderState {
  final OrderState orderData;
  const OrderSubmitted(this.orderData);
}
