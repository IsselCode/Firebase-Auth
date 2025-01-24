import 'package:flutter/material.dart';

class AppImages {

  static const logo = "assets/logos/logo.png";
  static const firstPage = "assets/images/homescreen.png";

  static const googleIcon = "assets/icons/google_icon.svg";
  static const twitterIcon = "assets/icons/twitter_icon.svg";
  static const phoneIcon = "assets/icons/phone_icon.svg";

}

class AppColors {

  static const background = Color(0xff0F101B);
  static const lightBackground = Color(0xff454756);
  static const grey = Color(0xff727385);

  static const primary = Color(0xff0F52FF);
  static const onPrimary = Color(0xffFFFFFF);
  static const secondary = Color(0xff5BD0F4);
  static const onSecondary = Color(0xffFFFFFF);
  static const error = Colors.red;
  static const onError = Color(0xffFFFFFF);
  static const surface = Color(0xff272832);
  static const onSurface = Color(0xffFFFFFF);

}

class AppGradients {

  static const scaffoldGradient = RadialGradient(
    center: Alignment.topLeft,
    radius: 0.9,
    stops: [
      0,
      1
    ],
    colors: [
      AppColors.lightBackground,
      AppColors.background,
    ]
  );

}

const SECONDS_FOR_SMS_AUTO_RETRIEVE_TIMEOUT = 60;













