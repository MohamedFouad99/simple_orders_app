import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_orders_app/core/helpers/spacing.dart';
import 'package:simple_orders_app/core/theming/style.dart';
import 'package:simple_orders_app/features/order/presentation/ui/widgets/app_text_form_field.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/colors.dart';
import '../../../data/model/cash_on_delivery_payment.dart';
import '../../../data/model/credit_card_payment.dart';
import '../../../data/model/pay_later_payment.dart';
import '../../../data/model/payment_method.dart';
import '../../controllers/order_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMethod = 'Credit Card'; // Default selection
  String? _cardNumber;
  String? _phoneNumber;
  void _savePaymentMethod() {
    PaymentMethod paymentMethod;

    if (_selectedMethod == 'Credit Card') {
      paymentMethod = CreditCardPayment(cardNumber: _cardNumber!);
    } else if (_selectedMethod == 'Pay Later') {
      paymentMethod = PayLaterPayment(phoneNumber: _phoneNumber!);
    } else {
      paymentMethod = CashOnDeliveryPayment();
    }

    context.read<OrderCubit>().updatePaymentMethod(paymentMethod);
    context.go('/review'); // Navigate to next step
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio Buttons for Payment Method
              Text(
                'Choose Payment Method:',
                style: TextStyles.font16DarkBlueBold,
              ),
              verticalSpace(8),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Credit Card',
                  style: TextStyles.font14DarkBlueRegular,
                ),
                value: 'Credit Card',
                groupValue: _selectedMethod,
                dense: true,
                activeColor: ColorsManager.secondary,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _selectedMethod = value!),
              ),

              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Cash on Delivery',
                  style: TextStyles.font14DarkBlueRegular,
                ),
                value: 'Cash on Delivery',
                groupValue: _selectedMethod,
                dense: true,
                activeColor: ColorsManager.secondary,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _selectedMethod = value!),
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Pay Later',
                  style: TextStyles.font14DarkBlueRegular,
                ),
                value: 'Pay Later',
                groupValue: _selectedMethod,
                dense: true,
                activeColor: ColorsManager.secondary,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _selectedMethod = value!),
              ),
              verticalSpace(8),
              // Credit Card Input (Only if Credit Card is selected)
              if (_selectedMethod == 'Credit Card') ...[
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
                    _cardNumber = value;
                  },
                ),
                verticalSpace(24),
              ],

              // Phone Number Input (Only if Pay Later is selected)
              if (_selectedMethod == 'Pay Later') ...[
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
                    _phoneNumber = value;
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
                    // Update Cubit State
                    _savePaymentMethod();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
