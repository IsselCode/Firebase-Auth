import 'dart:async';

import 'package:collaborative_app/core/services/snack_bar_service.dart';
import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/widgets/background_app_widget.dart';
import 'package:collaborative_app/src/widgets/texts/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../core/app/const.dart';

class CodeEntryScreen extends StatefulWidget {


  const CodeEntryScreen({super.key});

  @override
  State<CodeEntryScreen> createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {

  bool isLoading = false;
  int _counter = SECONDS_FOR_SMS_AUTO_RETRIEVE_TIMEOUT;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {

    if (_counter == 0) _counter = SECONDS_FOR_SMS_AUTO_RETRIEVE_TIMEOUT;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          _timer?.cancel();
        }

      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            // Fondo
            const BackgroundAppWidget(),

            // Cuerpo
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // Title
                      const _Title(),

                      const Gap(25),

                      // Description
                      const DescriptionWidget(text: "Por favor, ingresa el código que te hemos enviado"),

                      const Gap(25),

                      const _CodeInputField(),

                      const Gap(35),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("¿No recibiste el código?", style: TextStyle(color: AppColors.grey),),

                          const Gap(5),

                          if (_counter > 0)
                          Text(_counter.toString()),

                          if (_counter == 0 && isLoading == false)
                          TextButton(
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () async {

                              isLoading = true;
                              setState(() {});

                              startTimer();

                              AuthController authController = context.read();

                              await authController.resendCode();

                              isLoading = false;
                              setState(() {});

                            },
                            child: const Text("Reenviar código")
                          )

                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),

            // BackButton
            const BackButton(color: AppColors.onPrimary)

          ],
        )
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Ingresa el Código",
      style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.bold,
          height: 1
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CodeInputField extends StatelessWidget {
  const _CodeInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(5)
        )
      ),
      length: 6,
      onCompleted: (value) async {
        AuthController authController = context.read();
        SnackBarService snackBarService = context.read();

        try {

          await authController.verifyCode(value);

        } catch (e) {
          snackBarService.showSnackBar(e.toString());
        }

      },
    );
  }
}















