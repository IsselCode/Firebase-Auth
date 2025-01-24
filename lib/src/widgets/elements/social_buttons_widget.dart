import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/entities/user_entity.dart';
import 'package:collaborative_app/src/view/home_screen.dart';
import 'package:collaborative_app/src/view/sign_in_with_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/app/const.dart';
import '../buttons/icon_button_widget.dart';

class SocialButtonsWidget extends StatelessWidget {

  String text;

  SocialButtonsWidget({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [

        Text(text, style: const TextStyle(fontSize: 16, color: AppColors.grey),),

        const Gap(15),

        // Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            IconButtonWidget(
              svg: AppImages.googleIcon,
              onPressed: () => onGoogleSignInPressed(context),
            ),

            const Gap(35),

            IconButtonWidget(
              svg: AppImages.twitterIcon,
              iconColor: Colors.white,
              onPressed: () => onTwitterSignInPressed(context),
            ),

            const Gap(35),

            IconButtonWidget(
              svg: AppImages.phoneIcon,
              onPressed: () => onPhoneSignInPressed(context),
            )

          ],
        ),

      ],
    );
  }

  void onGoogleSignInPressed(BuildContext context) async {

    AuthController authController = context.read();
    
    try {
      
      UserEntity userEntity = await authController.signInWithGoogle();
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(),),
        (route) => false,
      );
      
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      
    }

  }

  void onTwitterSignInPressed(BuildContext context) async {
    AuthController authController = context.read();

    try {

      UserEntity userEntity = await authController.signInWithTwitter();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(),),
        (route) => false,
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }

  }

  void onPhoneSignInPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInWithPhoneScreen(),));
  }

}







