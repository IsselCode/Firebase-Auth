import 'package:flutter/material.dart';

class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navegar a una ruta específica
  Future<dynamic>? navigateTo(Widget screen) {
    return navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => screen,));
  }

  // Reemplaza la ruta actual con una nueva
  Future<dynamic>? replaceWith(Widget screen) {
    return navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => screen,));
  }

  // Regresa a la ruta anterior
  void goBack() {
    navigatorKey.currentState?.pop();
  }

  // Limpia el stack de navegación y navega a una nueva ruta
  Future<dynamic>? navigateAndClearStack(Widget screen) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen,),
      (route) => false,
    );
  }

}









