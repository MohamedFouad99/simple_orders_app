import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import 'section_title.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a widget for displaying a review section.

class ReviewSection extends StatelessWidget {
  final String title;
  final String editRoute;
  final List<Widget> details;

  const ReviewSection({
    super.key,
    required this.title,
    required this.editRoute,
    required this.details,
  });

  @override
  /// Builds the widget tree for the review section.
  ///
  /// This widget displays a section title with an edit icon, followed by
  /// a list of details and a divider. The details are passed as a list
  /// of widgets to the [details] parameter.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Displays the section title with an edit icon.
        SectionTitle(title: title, editRoute: editRoute),
        // Adds vertical spacing between the title and the details.
        verticalSpace(6),
        // Displays the list of details.
        ...details,
        // Displays a divider to separate sections.
        Divider(color: ColorsManager.gray, thickness: 0.8),
        // Adds vertical spacing after the divider.
        verticalSpace(16),
      ],
    );
  }
}
