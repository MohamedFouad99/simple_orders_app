import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/model/credit_card_payment.dart';
import '../../../data/model/pay_later_payment.dart';
import '../../controllers/order_cubit.dart';

import '../widgets/detail_row.dart';
import '../widgets/order_success_message.dart';
import '../widgets/review_section.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a screen for reviewing and submitting an order.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Builds the UI for the review screen.
    ///
    /// This widget displays a form with the customer's information, package
    /// details, and payment method. It also displays a button to submit the
    /// order and update the order state with the submitted order.
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
      body: UpDownAnimation(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is OrderSubmitting) {
                // If the order is being submitted, show a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }

              if (state is OrderSubmitted) {
                // If the order has been submitted, show a success message.
                return OrderSuccessMessage();
              }

              return Column(
                // If the order is not being submitted, show the review form.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReviewSection(
                    // Review section for the customer's information.
                    title: 'Customer Info',
                    editRoute: '/customer-info',
                    details: [
                      DetailRow(label: 'Name', value: state.name),
                      DetailRow(label: 'Phone', value: state.phone),
                      DetailRow(label: 'Address', value: state.address),
                    ],
                  ),
                  ReviewSection(
                    // Review section for the package details.
                    title: 'Package Details',
                    editRoute: '/package-details',
                    details: [
                      DetailRow(
                        label: 'Package Type',
                        value: state.packageType,
                      ),
                      DetailRow(label: 'Weight', value: '${state.weight} kg'),
                      if (state.notes != null)
                        DetailRow(label: 'Notes', value: state.notes!),
                    ],
                  ),
                  ReviewSection(
                    // Review section for the payment method.
                    title: 'Payment Method',
                    editRoute: '/payment',
                    details: [
                      DetailRow(
                        label: 'Method',
                        value:
                            state.paymentMethod?.methodName ??
                            'Cash on Delivery',
                      ),
                      if (state.paymentMethod is CreditCardPayment)
                        DetailRow(
                          label: 'Card Number',
                          value:
                              (state.paymentMethod as CreditCardPayment)
                                  .cardNumber,
                        ),
                      if (state.paymentMethod is PayLaterPayment)
                        DetailRow(
                          label: 'Phone',
                          value:
                              (state.paymentMethod as PayLaterPayment)
                                  .phoneNumber,
                        ),
                    ],
                  ),
                  verticalSpace(24),
                  // Submit button.
                  CustomButton(
                    label: 'Submit Order',
                    onTap: () {
                      context.read<OrderCubit>().submitOrder();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
