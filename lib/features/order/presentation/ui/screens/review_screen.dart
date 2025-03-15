// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_orders_app/core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../../../data/model/credit_card_payment.dart';
import '../../../data/model/pay_later_payment.dart';
import '../../controllers/order_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: CustomAppBar(title: 'Review & Submit'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            // Success Message
            if (state is OrderSubmitted) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/icons/correct.json',
                      width: 90.w,
                      fit: BoxFit.fill,
                    ),
                    verticalSpace(18),
                    Text(
                      'Order Submitted Successfully!',
                      style: TextStyles.font18DarkBlueBold,
                    ),
                    verticalSpace(18),
                    CustomButton(
                      label: 'Create New Order',
                      onTap: () => context.go('/customer-info'),
                    ),
                  ],
                ),
              );
            } else if (state is OrderSubmitting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                    title: 'Customer Info',
                    editRoute: '/customer-info',
                    context: context,
                  ),
                  verticalSpace(6),
                  _buildDetailRow('Name', state.name),
                  _buildDetailRow('Phone', state.phone),
                  _buildDetailRow('Address', state.address),
                  Divider(color: ColorsManager.gray, thickness: 0.8),
                  verticalSpace(16),
                  _buildSectionTitle(
                    context: context,
                    title: 'Package Details',
                    editRoute: '/package-details',
                  ),
                  verticalSpace(6),
                  _buildDetailRow('Package Type', state.packageType),
                  _buildDetailRow('Weight', '${state.weight} kg'),
                  if (state.notes != null)
                    _buildDetailRow('Notes', state.notes!),
                  Divider(color: ColorsManager.gray, thickness: 0.8),
                  verticalSpace(16),
                  _buildSectionTitle(
                    context: context,
                    title: 'Payment Method',
                    editRoute: '/payment',
                  ),
                  verticalSpace(6),
                  _buildDetailRow(
                    'Method',
                    state.paymentMethod?.methodName ?? 'Cash on Delivery',
                  ),
                  if (state.paymentMethod is CreditCardPayment)
                    _buildDetailRow(
                      'Card Number',
                      (state.paymentMethod as CreditCardPayment).cardNumber,
                    ),
                  if (state.paymentMethod is PayLaterPayment)
                    _buildDetailRow(
                      'Phone',
                      (state.paymentMethod as PayLaterPayment).phoneNumber,
                    ),
                  Divider(color: ColorsManager.gray, thickness: 0.8),
                  verticalSpace(24),
                  CustomButton(
                    label: 'Submit Order',
                    onTap: () {
                      context.read<OrderCubit>().submitOrder();
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required BuildContext context,
    required String title,
    required String editRoute,
  }) {
    return Row(
      children: [
        Text(title, style: TextStyles.font18DarkBlueBold),
        horizontalSpace(4),
        InkWell(
          onTap: () => context.go(editRoute), // Navigate to edit screen
          child: SvgPicture.asset(
            'assets/icons/pen_icon.svg',
            width: 18.w,
            color: ColorsManager.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyles.font14DarkBlueBold),
          Text(value, style: TextStyles.font14DarkBlueRegular),
        ],
      ),
    );
  }
}
