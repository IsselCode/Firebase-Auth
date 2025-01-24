import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/view/email_sent_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/app/const.dart';
import '../widgets/buttons/button_widget.dart';
import '../widgets/inputs/input_widget.dart';

class RestorePasswordScreen extends StatelessWidget {
  const RestorePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Body
            Container(
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
                          "Reestablecer contraseña",
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const Gap(25),

                        _Form(),

                        const Gap(25),

                      ],
                    ),
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

  TextEditingController emailController = TextEditingController();

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
              hintText: "ejemplo@gmail.com",
              validator: (value) {
                if (value!.isEmpty) return "Campo obligatorio";
              },
            ),

            const Gap(25),

            // Send Email
            ButtonWidget(
                onPressed: () => onEmailSentButtonPressed(context),
                size: const Size(180, double.infinity),
                text: "Enviar"
            ),
          ],
        )
    );
  }

  void onEmailSentButtonPressed(BuildContext context) async {

    if (!_formKey.currentState!.validate()){
      return ;
    }

    AuthController authController = context.read();

    try {

      await authController.sendPasswordResetEmail(emailController.text);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmailSentScreen(),));

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }




  }

}










