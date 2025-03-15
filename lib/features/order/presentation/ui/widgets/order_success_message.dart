import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../../../../core/widgets/custom_button.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a widget for displaying a success message after submitting an order.
class OrderSuccessMessage extends StatelessWidget {
  const OrderSuccessMessage({super.key});

  @override
  /// Builds the widget tree for the order success message.
  ///
  /// This widget displays a lottie animation, a text message indicating
  /// that the order was submitted successfully, and a button to create
  /// a new order.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Lottie Animation for success
          Lottie.asset(
            'assets/icons/correct.json',
            width: 90.w,
            fit: BoxFit.fill,
          ),
          // Space between animation and text
          verticalSpace(18),
          // Success message text
          Text(
            'Order Submitted Successfully!',
            style: TextStyles.font18DarkBlueBold,
          ),
          // Space between text and button
          verticalSpace(18),
          // Button to create a new order
          CustomButton(
            label: 'Create New Order',
            onTap: () => context.go('/customer-info'),
          ),
        ],
      ),
    );
  }
}
