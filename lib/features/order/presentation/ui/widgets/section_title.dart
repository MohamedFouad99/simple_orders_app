// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a widget for displaying a section title with an edit icon.
class SectionTitle extends StatelessWidget {
  final String title;
  final String editRoute;

  const SectionTitle({super.key, required this.title, required this.editRoute});

  @override
  /// Builds the widget tree for the section title.
  ///
  /// This widget displays a row containing the section title and an edit icon.
  /// Tapping the edit icon navigates to the specified [editRoute].
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Displays the section title with a specific text style.
        Text(title, style: TextStyles.font18DarkBlueBold),

        // Adds horizontal spacing between the title and the edit icon.
        horizontalSpace(4),

        // Displays an edit icon that navigates to the edit screen on tap.
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
}
