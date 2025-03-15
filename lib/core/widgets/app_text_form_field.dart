import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/style.dart';

// date: 15 March 2025
// by: Fouad
// last modified at: 15 March 2025
// purpose: Create a class that represents a custom text form field widget.
// The class takes various parameters to customize the appearance and behavior of the text form field.
class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? initialValue;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final void Function(String) onChanged;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final bool readOnly;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.maxLines,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    this.initialValue,
    this.onTap,
    required this.validator,
    required this.onChanged,
    this.readOnly = false,
    required this.keyboardType,
  });

  @override
  /// Builds a customizable `TextFormField` widget.
  ///
  /// The widget provides various customization options such as `hintText`,
  /// `suffixIcon`, `prefixIcon`, and `backgroundColor`. The `validator` and
  /// `onChanged` functions are used to handle input validation and changes,
  /// respectively. The text field can be set to read-only mode via the
  /// `readOnly` parameter. The `TextFormField` widget's appearance is further
  /// customized using the `InputDecoration` class, which allows setting borders,
  /// padding, and styles for hint text and input text.
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      initialValue: initialValue,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.blue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.darkGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font14DarkGreyRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? ColorsManager.white,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14GreyRegular,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
