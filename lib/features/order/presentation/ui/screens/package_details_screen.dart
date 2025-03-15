import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_orders_app/features/order/presentation/ui/widgets/app_text_form_field.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import '../../../../../core/utils/constants.dart';
import '../../controllers/order_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/drop_down_item.dart';

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
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
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
          child: CustomAppBar(title: 'Package Details'),
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
                Text('Package Type', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
                DropDownItem(
                  onChanged: (value) {
                    _packageType = value;
                  },
                  items:
                      AppConstants.packageTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                  text: 'Package Type',
                  validator:
                      (value) =>
                          value == null ? 'Please select a package type' : null,
                  value: _packageType,
                ),
                verticalSpace(12),
                Text('Weight', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
                AppTextFormField(
                  hintText: 'Weight (kg)',
                  suffixIcon: const SizedBox(),
                  keyboardType: TextInputType.number,
                  controller: _weightController,
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
                  onChanged: (value) {},
                ),
                verticalSpace(12),
                Text('Notes', style: TextStyles.font14DarkBlueRegular),
                verticalSpace(8),
                AppTextFormField(
                  maxLines: 5,
                  contentPadding: EdgeInsets.only(
                    top: 24.h,
                    right: 20.w,
                    left: 20.w,
                  ),
                  controller: _notesController,
                  hintText: 'Delivery Notes (Optional)',
                  suffixIcon: const SizedBox(),
                  keyboardType: TextInputType.text,
                  validator: (value) {},
                  onChanged: (value) {},
                ),
                verticalSpace(24),
                CustomButton(
                  label: 'Next',
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
    );
  }
}
