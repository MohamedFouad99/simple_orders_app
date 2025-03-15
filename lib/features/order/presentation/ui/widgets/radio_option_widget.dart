import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../../controllers/order_cubit.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a radio option widget for selecting a payment method.
class RadioOptionWidget extends StatelessWidget {
  const RadioOptionWidget({
    super.key,
    required this.state,
    required this.method,
  });
  final OrderState state;
  final String method;
  @override
  /// Builds the widget tree for the radio option widget.
  ///
  /// This widget returns a [RadioListTile] with the title set to the [method] parameter.
  /// The [value] parameter is set to the [method] parameter as well. The [groupValue]
  /// parameter is set to the [paymentMethod]?.methodName of the [state] parameter if
  /// it is not null. Otherwise, it is set to 'Cash on Delivery'. The [dense] parameter
  /// is set to true. The [activeColor] parameter is set to [ColorsManager.secondary].
  /// The [visualDensity] parameter is set to [VisualDensity.compact]. The [onChanged]
  /// parameter is set to a function that calls [selectPaymentMethod] on the
  /// [OrderCubit] with the provided [value] parameter when the radio button is changed.
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
