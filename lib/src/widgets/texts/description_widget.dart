import 'package:flutter/material.dart';

import '../../../core/app/const.dart';

class DescriptionWidget extends StatelessWidget {

  final String text;

  const DescriptionWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: AppColors.grey),
      textAlign: TextAlign.center,
    );
  }
}
