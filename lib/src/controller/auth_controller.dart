import 'dart:async';

import 'package:collaborative_app/core/app/enums.dart';
import 'package:collaborative_app/core/services/navigation_service.dart';
import 'package:collaborative_app/core/services/snack_bar_service.dart';
import 'package:collaborative_app/src/entities/phone_auth_state_entity.dart';
import 'package:collaborative_app/src/model/auth_model.dart';
import 'package:collaborative_app/src/view/code_entry_screen.dart';
import 'package:collaborative_app/src/view/home_screen.dart';
import 'package:collaborative_app/src/view/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../entities/user_entity.dart';

class AuthController extends ChangeNotifier {

  AuthModel authModel;
  NavigationService navigationService;
  SnackBarService snackBarService;

  AuthController({
    required this.authModel,
    required this.navigationService,
    required this.snackBarService
  }) {
    authModel.userStream.listen((UserEntity? userEntity) {

      if (userEntity != null) {
        user = userEntity;
        navigationService.navigateAndClearStack(const HomeScreen());
        snackBarService.showSnackBar("El usuario ha sido persistente");
      } else {
        user = null;
        navigationService.navigateAndClearStack(const SignInScreen());
        snackBarService.showSnackBar("No se ha encontrado ningun usuario activo");
      }

    },);
  }

  UserEntity? user;

  late StreamSubscription<PhoneAuthStateEntity>? subscription;

  String? tempPhoneNumber;
  String? tempCountryCode;

  String? verificationId;
  int? resendToken;

  void _subscribe() {

    subscription = authModel.authStateStream.listen((event) async {

      switch (event.type) {

        case PhoneAuthStateType.completed:
          snackBarService.showSnackBar("Autenticación completada");
          user = event.userEntity;
          await subscription?.cancel();
        case PhoneAuthStateType.failed:
          snackBarService.showSnackBar("Error: ${event.errorMessage}");
          await subscription?.cancel();
        case PhoneAuthStateType.codeSent:
          snackBarService.showSnackBar("Código enviado");
          verificationId = event.verificationId;
          resendToken = event.resendToken;

          if (!event.isResend!) {
            navigationService.navigateTo(const CodeEntryScreen());
          }

        case PhoneAuthStateType.timeout:
          snackBarService.showSnackBar("Tiempo de espera agotado");
          await subscription?.cancel();
      }

    },);

  }

  Future<void> verifyPhoneNumber(String countryCode, String phoneNumber) async {

    _subscribe();

    // +52 8344281215
    await authModel.verifyPhoneNumber("+$countryCode $phoneNumber", null);

    tempPhoneNumber = phoneNumber;
    tempCountryCode = countryCode;

  }

  Future<void> resendCode() async {

    _subscribe();

    await authModel.verifyPhoneNumber("+$tempCountryCode $tempPhoneNumber", resendToken);

  }

  Future<void> verifyCode(String code) async {

    await authModel.verifyCode(code, verificationId!);
    await subscription?.cancel();

  }

  Future<void> signOut() async => await authModel.signOut();

  Future<UserEntity> createUserWithEmailAndPassword(String email, String password, String name) async {

    UserEntity userEntity = await authModel.createUserWithEmailAndPassword(email, password, name);

    user = userEntity;

    return userEntity;

  }

  Future<UserEntity> signInWithEmailAndPassword(String password, String email) async {

    UserEntity userEntity = await authModel.signInWithEmailAndPassword(password, email);

    user = userEntity;

    return user!;

  }

  Future<void> sendPasswordResetEmail(String email) async {

    await authModel.sendPasswordResetEmail(email);

  }

  Future<UserEntity> signInWithGoogle() async {

    UserEntity userEntity = await authModel.signInWithGoogle();

    user = userEntity;

    return userEntity;

  }

  Future<UserEntity> signInWithTwitter() async {

    UserEntity userEntity = await authModel.signInWithTwitter();

    user = userEntity;

    return userEntity;

  }

}
















