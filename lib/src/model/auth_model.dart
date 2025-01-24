import 'dart:async';

import 'package:collaborative_app/core/app/const.dart';
import 'package:collaborative_app/src/entities/phone_auth_state_entity.dart';
import 'package:collaborative_app/src/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModel {

  FirebaseAuth firebaseAuth;

  final StreamController<UserEntity?> _userStreamController = StreamController<UserEntity?>();
  final StreamController<PhoneAuthStateEntity> _authStateController = StreamController<PhoneAuthStateEntity>.broadcast();

  AuthModel({
    required this.firebaseAuth,
  }) {

    firebaseAuth.authStateChanges().listen((User? user) {

      // Si el usuario no es nulo, asignar el UserEntity al stream controller
      if (user != null) {
        _userStreamController.add(UserEntity(
          uid: user.uid,
          name: user.displayName ?? "",
          email: user.email ?? ""
        ));
      } else {
        // Si el usuario es nulo, entonces agregar un null al stream controller
        _userStreamController.add(null);
      }

    },);

  }

  Stream<UserEntity?> get userStream => _userStreamController.stream;
  Stream<PhoneAuthStateEntity> get authStateStream => _authStateController.stream;

  Future<void> signOut() async => await firebaseAuth.signOut();

  Future<UserEntity> createUserWithEmailAndPassword(String email, String password, String name) async {

    try {

      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      UserEntity userEntity = UserEntity(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? ""
      );

      return userEntity;

    } on FirebaseAuthException catch (e) {

      // String errorMessage = e.code;

      throw Exception(e.message ?? "Error desconocido");

    }

  }

  Future<UserEntity> signInWithEmailAndPassword(String password, String email) async {

    try {

      UserCredential firebaseUser = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      UserEntity userEntity = UserEntity(
        uid: firebaseUser.user!.uid,
        name: firebaseUser.user!.displayName ?? "",
        email: firebaseUser.user!.email ?? ""
      );

      return userEntity;

    } on FirebaseAuthException catch (e) {

      throw Exception(e.message ?? "Error desconocido");

    }

  }

  Future<void> sendPasswordResetEmail(String email) async {

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      throw Exception(e.message ?? "Error desconocido");
    }

  }

  Future<UserEntity> signInWithGoogle() async {

    try {
      // Activar el flujo de autenticación
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtener los detalles de autenticación de la solicitud
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Crear una nueva credencial
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      // Iniciar sesión con la credencial
      UserCredential firebaseUser = await firebaseAuth.signInWithCredential(credential);

      // Crear el userEntity
      UserEntity userEntity = UserEntity(
          uid: firebaseUser.user!.uid,
          name: firebaseUser.user!.displayName ?? "",
          email: firebaseUser.user!.email ?? ""
      );

      return userEntity;
    } on FirebaseAuthException catch(e) {

      throw Exception(e.message ?? "Error desconocido");

    }

  }

  Future<UserEntity> signInWithTwitter() async {

    try {

      UserCredential userCredential = await firebaseAuth.signInWithProvider(TwitterAuthProvider());

      UserEntity userEntity = UserEntity(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? ""
      );

      return userEntity;

    } on FirebaseAuthException catch(e) {
      throw Exception(e.message ?? "Error desconocido");
    }

  }

  Future<void> verifyPhoneNumber(String fullPhoneNumber, int? forceResendingToken) async {

    try {

      firebaseAuth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        timeout: const Duration(seconds: SECONDS_FOR_SMS_AUTO_RETRIEVE_TIMEOUT),
        forceResendingToken: forceResendingToken,
        verificationCompleted: (PhoneAuthCredential credential) async {

          try {

            UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

            UserEntity userEntity = UserEntity(
              uid: userCredential.user!.uid,
              name: userCredential.user!.displayName ?? "",
              email: userCredential.user!.email ?? ""
            );

            _authStateController.add(PhoneAuthStateEntity.completed(userEntity));

          } catch (e) {

            _authStateController.add(PhoneAuthStateEntity.failed(
              "Error al iniciar sesión automáticamente: ${e.toString()}")
            );

          }

        },
        verificationFailed: (FirebaseAuthException error) {
          _authStateController.add(PhoneAuthStateEntity.failed(error.message ?? "Error desconocido"));
        },
        codeSent: (verificationId, resedingToken) {
          bool isResend = forceResendingToken == null ? false : true;

          _authStateController.add(PhoneAuthStateEntity.codeSent(verificationId, resedingToken, isResend));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _authStateController.add(PhoneAuthStateEntity.timeout(verificationId));
        },
      );

    } catch (e) {
      _authStateController.add(PhoneAuthStateEntity.failed("Error general: ${e.toString()}"));
    }

  }

  Future<UserEntity> verifyCode(String code, String verificationId) async {

    try {

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      UserEntity userEntity = UserEntity(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? ""
      );

      return userEntity;

    } catch (e) {

      throw Exception(e.toString());

    }

  }

}









