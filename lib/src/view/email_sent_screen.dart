import 'package:collaborative_app/src/view/sign_in_screen.dart';
import 'package:collaborative_app/src/widgets/texts/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/app/const.dart';
import '../widgets/buttons/button_widget.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: AppGradients.scaffoldGradient),
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Title
                  const Text(
                    "Correo enviado",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Gap(25),

                  const DescriptionWidget(text: "Si el correo ingresado pertenece a una cuenta registrada, hemos enviado un enlace para restablecer tu contraseña."),

                  const Gap(25),

                  ButtonWidget(
                    onPressed: () => onBackButtonPressed(context),
                    size: const Size(180, double.infinity),
                    text: "Volver"
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBackButtonPressed(BuildContext context) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen(),));

}