import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../../data/model/credit_card_payment.dart';
import '../../../data/model/pay_later_payment.dart';
import '../../controllers/order_cubit.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../widgets/radio_option_widget.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a screen for entering payment information.
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cardNumberController;
  late TextEditingController _phoneNumberController;

  @override
  /// Initializes the text editing controllers with the current state of the order.
  ///
  /// This method is called when the widget is first initialized.
  /// It sets the text of the [_cardNumberController] and [_phoneNumberController]
  /// to the current state of the order. If the payment method is a [CreditCardPayment],
  /// it sets the text of the [_cardNumberController] to the card number of the
  /// payment method. If the payment method is a [PayLaterPayment], it sets the
  /// text of the [_phoneNumberController] to the phone number of the payment method.
  void initState() {
    super.initState();
    final state = context.read<OrderCubit>().state;

    // Initialize controllers with existing values from OrderCubit
    _cardNumberController = TextEditingController(
      text:
          state.paymentMethod is CreditCardPayment
              ? (state.paymentMethod as CreditCardPayment).cardNumber
              : '',
    );

    _phoneNumberController = TextEditingController(
      text:
          state.paymentMethod is PayLaterPayment
              ? (state.paymentMethod as PayLaterPayment).phoneNumber
              : '',
    );
  }

  @override
  /// Disposes the text editing controllers to free up resources.
  ///
  /// This method is called when the widget is removed from the widget tree.
  /// It ensures that the [_cardNumberController] and [_phoneNumberController]
  /// are properly disposed of to prevent memory leaks.
  void dispose() {
    _cardNumberController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  /// Builds the UI for the payment screen.
  ///
  /// This widget displays a form with input fields for the payment method,
  /// credit card number, and phone number. It also displays a button to
  /// navigate to the review screen and update the order state with the
  /// payment information. The form is validated and the user is prevented
  /// from navigating to the next screen until all fields are valid.
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
      body: UpDownAnimation(
        reverse: true,
        child: Padding(
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
                    RadioOptionWidget(method: 'Cash on Delivery', state: state),
                    RadioOptionWidget(method: 'Credit Card', state: state),
                    RadioOptionWidget(method: 'Pay Later', state: state),
                    verticalSpace(8),
                    // Credit Card Input (Only if Credit Card is selected)
                    if (state.paymentMethod is CreditCardPayment) ...[
                      AppTextFormField(
                        /// Sets the controller for the text field to the
                        /// [_cardNumberController].
                        controller: _cardNumberController,
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
                        /// Sets the controller for the text field to the
                        /// [_phoneNumberController].
                        controller: _phoneNumberController,
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
      ),
    );
  }
}
