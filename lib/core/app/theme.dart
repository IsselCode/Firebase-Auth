import 'package:collaborative_app/core/app/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface
  ),

  textTheme: TextTheme(
    bodyMedium: GoogleFonts.roboto(),
    displayMedium: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    titleLarge: GoogleFonts.roboto(fontSize: 28, fontWeight: FontWeight.bold)
  )

);