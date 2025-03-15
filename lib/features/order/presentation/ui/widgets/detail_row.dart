import 'package:flutter/material.dart';

import '../../../../../core/theming/style.dart';

//date: 15 March 2025
//by: Fouad
//last modified at: 15 March 2025
//description: Create a class that represents a detail row widget for displaying a label and value.
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  /// Builds the widget tree for the detail row widget.
  ///
  /// This widget returns a [Row] with two [Text] widgets. The first [Text]
  /// widget displays the [label] parameter with a bold font style. The second
  /// [Text] widget displays the [value] parameter with a regular font style.
  /// The [mainAxisAlignment] parameter is set to [MainAxisAlignment.spaceBetween]
  /// to align the text widgets to the left and right sides of the row.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Label text widget with bold font style.
          Text(label, style: TextStyles.font14DarkBlueBold),

          /// Value text widget with regular font style.
          Text(value, style: TextStyles.font14DarkBlueRegular),
        ],
      ),
    );
  }
}
