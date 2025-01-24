import 'package:collaborative_app/src/view/sign_in_screen.dart';
import 'package:collaborative_app/src/widgets/buttons/button_widget.dart';
import 'package:collaborative_app/src/widgets/texts/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/app/const.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.scaffoldGradient),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.firstPage, height: 300, width: 300,),

                const Gap(100),

                Column(
                  children: [

                    // Text Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.logo, height: 42, width: 42,),

                        const Gap(10),

                        const _TextLogo()

                      ],
                    ),

                    const Gap(5),

                    // Sub Text
                    const DescriptionWidget(text: "Colabora, crea, y alcanza tus metas en equipo"),

                    const Gap(40),

                    ButtonWidget(
                      onPressed: () => onPressStartButton(context),
                      text: "Empezar",
                      size: Size(160, double.infinity),
                    )

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }


  void onPressStartButton(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen(),)
    );
  }


}

class _TextLogo extends StatelessWidget {
  const _TextLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: "Flow ",
        style: TextStyle(color: AppColors.primary, fontSize: 36, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Tasker",
            style: TextStyle(color: AppColors.secondary)
          )
        ]
      ),

    );
  }
}