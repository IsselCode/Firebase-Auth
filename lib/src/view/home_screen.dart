import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = context.read();

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authController.signOut();
          },
          child: const Text("Salir")
        ),
      ),
    );
  }
}
