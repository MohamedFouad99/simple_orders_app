import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../../controllers/order_cubit.dart';

class RadioOptionWidget extends StatelessWidget {
  const RadioOptionWidget({
    super.key,
    required this.state,
    required this.method,
  });
  final OrderState state;
  final String method;
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(method, style: TextStyles.font14DarkBlueRegular),
      value: method,
      groupValue: state.paymentMethod?.methodName ?? 'Cash on Delivery',
      dense: true,
      activeColor: ColorsManager.secondary,
      visualDensity: VisualDensity.compact,
      onChanged:
          (value) => context.read<OrderCubit>().selectPaymentMethod(value!),
    );
  }
}
