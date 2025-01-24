import 'package:flutter/material.dart';

import '../../core/app/const.dart';

class BackgroundAppWidget extends StatelessWidget {
  const BackgroundAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: AppGradients.scaffoldGradient
      ),
    );
  }
}