import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../controllers/order_cubit.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a screen for entering customer information.

class CustomerInfoScreen extends StatefulWidget {
  const CustomerInfoScreen({super.key});

  @override
  CustomerInfoScreenState createState() => CustomerInfoScreenState();
}

class CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  /// Initializes the controllers with the current state of the order.
  ///
  /// This method is called when the widget is first initialized.
  /// It sets the text of the [_nameController], [_phoneController],
  /// and [_addressController] to the current state of the order.
  void initState() {
    super.initState();
    final state = context.read<OrderCubit>().state;
    _nameController = TextEditingController(text: state.name);
    _phoneController = TextEditingController(text: state.phone);
    _addressController = TextEditingController(text: state.address);
  }

  @override
  /// Disposes the text editing controllers to free up resources.
  ///
  /// This method is called when the widget is removed from the widget tree.
  /// It ensures that the [_nameController], [_phoneController], and
  /// [_addressController] are properly disposed of to prevent memory leaks.
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  /// Builds the UI for the customer info screen.
  ///
  /// This widget displays a form with input fields for the customer's name,
  /// phone number, and address. It also displays a button to navigate to the
  /// package details screen and update the order state with the customer's
  /// information. The form is validated and the user is prevented from
  /// navigating to the next screen until all fields are valid.
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
      body: UpDownAnimation(
        reverse: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name text field
                  Text('Name', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: 'Name',
                    controller: _nameController,
                    suffixIcon: const SizedBox(),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),

                  /// Phone number text field
                  verticalSpace(12),
                  Text('Phone Number', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: 'Phone Number',
                    suffixIcon: const SizedBox(),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone is required';
                      }
                      if (!AppRegex.isPhoneNumberValid(value)) {
                        return "Number must start with 5 and consist of 9 digits.";
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),

                  /// Address text field
                  verticalSpace(12),
                  Text('Address', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  AppTextFormField(
                    hintText: 'Address',
                    suffixIcon: const SizedBox(),
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  verticalSpace(24),

                  /// Next button
                  CustomButton(
                    label: 'Next',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Update Cubit State
                        context.read<OrderCubit>().updateCustomerInfo(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
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
      ),
    );
  }
}
