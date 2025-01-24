import 'package:collaborative_app/core/app/theme.dart';
import 'package:collaborative_app/core/services/navigation_service.dart';
import 'package:collaborative_app/core/services/snack_bar_service.dart';
import 'package:collaborative_app/src/controller/auth_controller.dart';
import 'package:collaborative_app/src/model/auth_model.dart';
import 'package:collaborative_app/src/view/code_entry_screen.dart';
import 'package:collaborative_app/src/view/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FirebaseAuth.instance,),
        Provider(create: (context) => AuthModel(firebaseAuth: context.read()),),
        Provider(create: (context) => NavigationService(),),
        Provider(create: (context) => SnackBarService(),),
        ChangeNotifierProvider(create: (context) => AuthController(
          authModel: context.read(),
          navigationService: context.read(),
          snackBarService: context.read()
        ),)
      ],
      child: Consumer<NavigationService>(
        builder: (context, navigationService, child) {
          SnackBarService snackBarService = context.read();
          return MaterialApp(
            title: 'Flutter Demo',
            navigatorKey: navigationService.navigatorKey,
            scaffoldMessengerKey: snackBarService.scaffoldKey,
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            home: const FirstScreen()
          );
        },
      ),
    );
  }
}