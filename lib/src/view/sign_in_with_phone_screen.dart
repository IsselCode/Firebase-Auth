import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/view/code_entry_screen.dart';
import 'package:collaborative_app/src/widgets/background_app_widget.dart';
import 'package:collaborative_app/src/widgets/buttons/button_widget.dart';
import 'package:collaborative_app/src/widgets/texts/description_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../core/app/const.dart';

class SignInWithPhoneScreen extends StatefulWidget {

  SignInWithPhoneScreen({super.key});

  @override
  State<SignInWithPhoneScreen> createState() => _SignInWithPhoneScreenState();
}

class _SignInWithPhoneScreenState extends State<SignInWithPhoneScreen> {

  TextEditingController phoneNumberController = TextEditingController();
  Country? country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            // Fondo con Gradiente
            const BackgroundAppWidget(),

            // Contenido principal
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // Titulo
                      const _Title(),

                      const Gap(25),

                      const DescriptionWidget(text: "Por favor, ingresa tu número telefónico"),

                      const Gap(25),

                      _PhoneInput(
                        controller: phoneNumberController,
                        country: country,
                        onSelect: (newCountry) {
                          setState(() {
                            country = newCountry;
                          });
                        },
                      ),

                      const Gap(25),

                      ButtonWidget(
                        onPressed: () async => onSignUpPressed(context),
                        size: const Size(180, double.infinity),
                        text: "Registrarse"
                      )

                    ],
                  ),
                ),
              ),
            ),

            const BackButton(color: AppColors.onPrimary)

          ],
        )
      ),
    );
  }

  Future<void> onSignUpPressed(BuildContext context) async {

    AuthController authController = context.read();

    if (phoneNumberController.text.isEmpty) {
      print("Ingresa el número teléfonico");
      return;
    }

    if (country == null) {
      print("Selecciona un país");
      return;
    }

    try {
      await authController.verifyPhoneNumber(country!.phoneCode, phoneNumberController.text);
    } catch (e) {
      print(e.toString());
    }

  }

}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Verifica tu número",
      style: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        height: 0.8
      ),
      textAlign: TextAlign.center,
    );
  }
}


class _PhoneInput extends StatelessWidget {

 Country? country;
 void Function(Country country) onSelect;
 TextEditingController controller;

 _PhoneInput({
   super.key,
   required this.country,
   required this.onSelect,
   required this.controller
 });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        FilledButton(
          onPressed: () => _showCountryPicker(context),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            fixedSize: const Size(80, 50),
            padding: const EdgeInsets.all(15)
          ),
          child: Text(country == null ? "+" : "+${country!.phoneCode}", style: const TextStyle(fontSize: 16),)
        ),

        const Gap(5),

        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: AppColors.onSurface),
            expands: true,
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              hintText: "837584358",
              hintStyle: const TextStyle(color: AppColors.grey),
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              constraints: const BoxConstraints(
                maxHeight: 50,
                minHeight: 50
              )
            ),
          ),
        )

      ],
    );
  }

  _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      favorite: ["MX", "US"],
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(5),
        inputDecoration: InputDecoration(
          labelText: "Buscar",
          hintText: "+52 o México",
          prefixIcon: const Icon(Icons.search_outlined),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2)
            )
          )
        )
      ),
      onSelect: onSelect,
    );
  }

}







