import 'package:collaborative_app/src/view/home_screen.dart';
import 'package:collaborative_app/src/widgets/background_app_widget.dart';
import 'package:collaborative_app/src/widgets/buttons/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/app/const.dart';
import '../controller/auth_controller.dart';
import '../widgets/elements/social_buttons_widget.dart';
import '../widgets/inputs/input_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            // Fondo con Gradiente
            const BackgroundAppWidget(),

            // Body
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // Title
                      const Text(
                        "Crea una cuenta",
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
                        text: "Regístrate con",
                      ),

                      const Gap(25),

                      _Form(),

                      const Gap(25),

                    ],
                  ),
                ),
              ),
            ),

            // Back Button
            const BackButton(
              color: AppColors.onPrimary,
            )

          ],
        ),
      ),
    );
  }

}

class _Form extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _Form({super.key});

  TextEditingController userController = TextEditingController();
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
            textEditingController: userController,
            text: "Usuario",
            hintText: "John",
            validator: (value) {
              if (value!.isEmpty) return "Campo obligatorio";
            },
          ),

          const Gap(25),

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
              if (value.length <= 6) return "Contraseña es muy debil";
            },
          ),

          const Gap(25),

          // Sign In
          ButtonWidget(
              onPressed: () => onEmailSignUpPressed(context),
              size: const Size(180, double.infinity),
              text: "Registrarse"
          ),
        ],
      )
    );
  }

  void onEmailSignUpPressed(BuildContext context) async {

    if (!_formKey.currentState!.validate()){
      return ;
    }

    // Lógica
    AuthController authController = context.read();

    try {

      await authController.createUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
        userController.text
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen(),),
        (route) => false,
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );

    }


  }

}








