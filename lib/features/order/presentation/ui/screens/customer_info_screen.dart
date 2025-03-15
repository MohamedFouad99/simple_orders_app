import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_orders_app/core/helpers/spacing.dart';
import 'package:simple_orders_app/features/order/presentation/ui/widgets/custom_button.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/theming/style.dart';
import '../../controllers/order_cubit.dart';
import '../widgets/app_text_form_field.dart';
import '../widgets/custom_app_bar.dart';

class CustomerInfoScreen extends StatefulWidget {
  const CustomerInfoScreen({super.key});

  @override
  CustomerInfoScreenState createState() => CustomerInfoScreenState();
}

class CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _address = '';

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
          child: CustomAppBar(title: 'Customer Info'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
                AppTextFormField(
                  hintText: 'Name',
                  suffixIcon: const SizedBox(),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                  },
                ),

                verticalSpace(12),
                Text('Phone Number', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
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
                    _phone = value;
                  },
                ),
                verticalSpace(12),
                Text('Address', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
                AppTextFormField(
                  hintText: 'Address',
                  suffixIcon: const SizedBox(),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _address = value;
                  },
                ),
                verticalSpace(24),
                CustomButton(
                  label: 'Next',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Update Cubit State
                      context.read<OrderCubit>().updateCustomerInfo(
                        name: _name,
                        phone: _phone,
                        address: _address,
                      );
                      context.go('/package-details');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
