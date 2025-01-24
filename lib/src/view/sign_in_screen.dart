import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/entities/user_entity.dart';
import 'package:collaborative_app/src/view/home_screen.dart';
import 'package:collaborative_app/src/view/restore_password_screen.dart';
import 'package:collaborative_app/src/view/sign_up_screen.dart';
import 'package:collaborative_app/src/widgets/buttons/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/app/const.dart';
import '../widgets/elements/social_buttons_widget.dart';
import '../widgets/inputs/input_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = context.read();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.scaffoldGradient),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Title
                  const Text(
                    "Inicia Sesión",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      height: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Gap(25),

                  // Social Buttons
                  SocialButtonsWidget(
                    text: "Ingresa con",
                  ),

                  const Gap(25),

                  _Form(),

                  const Gap(25),

                  // Sign Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        "¿No tienes una cuenta? ",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16
                        ),
                      ),

                      TextButton(
                        onPressed: () => onSignUpPressed(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                        ),
                        child: const Text(
                          "Registrate",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16
                          ),
                        )
                      )

                    ],
                  ),

                  // Restore Password
                  Transform.translate(
                    offset: const Offset(0, -15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text(
                          "¿Olvidaste tu contraseña? ",
                          style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16
                          ),
                        ),

                        TextButton(
                            onPressed: () => onRestorePasswordPressed(context),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                            ),
                            child: const Text(
                              "Recupérala",
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16
                              ),
                            )
                        )

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void onSignUpPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));

  void onRestorePasswordPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const RestorePasswordScreen(),));

}

class _Form extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _Form({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Flex(
        direction: Axis.vertical,
        children: [
          InputWidget(
            textEditingController: emailController,
            text: "Correo",
            hintText: "correo@gmail.com",
            validator: (value) {
              if (value!.isEmpty) return "Campo obligatorio";
            },
          ),

          const Gap(25),

          InputWidget(
            textEditingController: passwordController,
            text: "Contraseña",
            hintText: "******",
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) return "Campo obligatorio";
              if (value.length <= 6) return "La contraseña es muy debil";
            },
          ),

          const Gap(25),

          // Sign In
          ButtonWidget(
              onPressed: () => onEmailSignInPressed(context),
              size: const Size(180, double.infinity),
              text: "Iniciar Sesión"
          ),
        ],
      )
    );
  }

  void onEmailSignInPressed(BuildContext context) async {

    if (!_formKey.currentState!.validate()){
      return ;
    }

    AuthController authController = context.read();

    try {

      UserEntity userEntity = await authController.signInWithEmailAndPassword(passwordController.text, emailController.text);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(),),
        (route) => false,
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }

  }

}
















