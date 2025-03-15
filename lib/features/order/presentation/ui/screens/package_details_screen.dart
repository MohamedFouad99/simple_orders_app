import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../../../../core/utils/constants.dart';
import '../../controllers/order_cubit.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/drop_down_item.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a screen for entering package details.
class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({super.key});

  @override
  PackageDetailsScreenState createState() => PackageDetailsScreenState();
}

class PackageDetailsScreenState extends State<PackageDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _packageType;
  late TextEditingController _weightController;
  late TextEditingController _notesController;
  @override
  /// Initializes the controllers with the current state of the order.
  ///
  /// This method is called when the widget is first initialized.
  /// It sets the text of the [_weightController], [_notesController],
  /// and the [_packageType] to the current state of the order.
  void initState() {
    super.initState();
    final state = context.read<OrderCubit>().state;
    _packageType = state.packageType.isEmpty ? null : state.packageType;
    _weightController = TextEditingController(
      text: state.weight > 0 ? state.weight.toString() : '',
    );
    _notesController = TextEditingController(text: state.notes ?? '');
  }

  @override
  /// Disposes the text editing controllers to free up resources.
  ///
  /// This method is called when the widget is removed from the widget tree.
  /// It ensures that the [_weightController] and [_notesController] are properly
  /// disposed of to prevent memory leaks.
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  /// Builds the UI for the package details screen.
  ///
  /// This widget displays a form with input fields for the package type,
  /// weight, and notes. It also displays a button to navigate to the
  /// payment screen and update the order state with the package details.
  /// The form is validated and the user is prevented from navigating to
  /// the next screen until all fields are valid.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: CustomAppBar(title: 'Package Details'),
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
                  /// Package Type field
                  Text('Package Type', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  DropDownItem(
                    /// Updates the [_packageType] field with the selected value.
                    onChanged: (value) {
                      _packageType = value;
                    },

                    /// List of package types to display in the dropdown.
                    items:
                        AppConstants.packageTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),

                    /// Hint text to display when no item is selected.
                    text: 'Package Type',

                    /// Validator function to ensure the user selects an item.
                    validator:
                        (value) =>
                            value == null
                                ? 'Please select a package type'
                                : null,

                    /// The selected value, or null if no value is selected.
                    value: _packageType,
                  ),
                  verticalSpace(12),

                  /// Weight field
                  Text('Weight', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  AppTextFormField(
                    /// Hint text to display in the text field.
                    hintText: 'Weight (kg)',

                    /// The suffix icon to display.
                    suffixIcon: const SizedBox(),

                    /// The keyboard type to use for the text field.
                    keyboardType: TextInputType.number,

                    /// The controller for the text field.
                    controller: _weightController,

                    /// Validator function to ensure the user enters a valid weight.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Weight is required';
                      }
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Enter a valid weight';
                      }
                      return null;
                    },

                    /// Function called when the user changes the text in the text field.
                    onChanged: (value) {},
                  ),
                  verticalSpace(12),

                  /// Notes field
                  Text('Notes', style: TextStyles.font14DarkBlueRegular),
                  verticalSpace(8),
                  AppTextFormField(
                    /// Maximum number of lines to display in the text field.
                    maxLines: 5,

                    /// Additional padding to add to the text field.
                    contentPadding: EdgeInsets.only(
                      top: 24.h,
                      right: 20.w,
                      left: 20.w,
                    ),

                    /// The controller for the text field.
                    controller: _notesController,

                    /// Hint text to display in the text field.
                    hintText: 'Delivery Notes (Optional)',

                    /// The suffix icon to display.
                    suffixIcon: const SizedBox(),

                    /// The keyboard type to use for the text field.
                    keyboardType: TextInputType.text,

                    /// Validator function to ensure the user enters valid input.
                    validator: (value) {},

                    /// Function called when the user changes the text in the text field.
                    onChanged: (value) {},
                  ),
                  verticalSpace(24),

                  /// Next button
                  CustomButton(
                    /// The label to display on the button.
                    label: 'Next',

                    /// Function called when the user taps the button.
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Update Cubit State
                        context.read<OrderCubit>().updatePackageDetails(
                          packageType: _packageType!,
                          weight: double.parse(_weightController.text),
                          notes: _notesController.text,
                        );
                        context.go('/payment');
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
