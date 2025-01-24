import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app/const.dart';

class IconButtonWidget extends StatelessWidget {

  VoidCallback onPressed;
  String svg;
  Color? iconColor;

  IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.svg,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          padding: const EdgeInsets.all(15)
        ),
        icon: SvgPicture.asset(
          svg,
          colorFilter: iconColor != null ? ColorFilter.mode(
              iconColor!,
              BlendMode.srcIn
          ) : null,
          height: 21,
          width: 21,
        )
    );
  }
}
