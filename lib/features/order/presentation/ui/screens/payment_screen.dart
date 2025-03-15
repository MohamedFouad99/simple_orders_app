import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_orders_app/core/helpers/spacing.dart';
import 'package:simple_orders_app/core/theming/style.dart';
import 'package:simple_orders_app/features/order/presentation/ui/widgets/app_text_form_field.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/colors.dart';
import '../../../data/model/credit_card_payment.dart';
import '../../../data/model/pay_later_payment.dart';
import '../../controllers/order_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/radio_option_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

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
          child: CustomAppBar(title: 'Payment'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio Buttons for Payment Method
                  Text(
                    'Choose Payment Method:',
                    style: TextStyles.font16DarkBlueBold,
                  ),
                  verticalSpace(8),
                  RadioOptionWidget(method: 'Credit Card', state: state),
                  RadioOptionWidget(method: 'Cash on Delivery', state: state),
                  RadioOptionWidget(method: 'Pay Later', state: state),

                  verticalSpace(8),
                  // Credit Card Input (Only if Credit Card is selected)
                  if (state.paymentMethod is CreditCardPayment) ...[
                    AppTextFormField(
                      hintText: 'Card Number',
                      suffixIcon: const SizedBox(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Card number is required';
                        }
                        if (!RegExp(r'^\d{16}$').hasMatch(value)) {
                          return 'Enter a valid 16-digit card number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<OrderCubit>().updatePaymentMethod(
                          CreditCardPayment(cardNumber: value),
                        );
                      },
                    ),
                    verticalSpace(24),
                  ],

                  // Phone Number Input (Only if Pay Later is selected)
                  if (state.paymentMethod is PayLaterPayment) ...[
                    AppTextFormField(
                      hintText: 'Phone Number',
                      suffixIcon: const SizedBox(),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone is required';
                        }
                        if (!AppRegex.isPhoneNumberValid(value)) {
                          return "Number must start with 5 and consist of 9 digits.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<OrderCubit>().updatePaymentMethod(
                          PayLaterPayment(phoneNumber: value),
                        );
                      },
                    ),
                    verticalSpace(24),
                  ],
                  // Next Button
                  CustomButton(
                    label: 'Next',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.go('/review');
                      }
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
