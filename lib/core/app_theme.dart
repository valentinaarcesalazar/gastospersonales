import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFEA00FF);
  static const Color background = Color(0xFF0F0A1A);
  static const Color card = Color(0xFF1A1326);
  static const Color accentBlue = Color(0xFF00E5FF);
  static const Color accent = Color(0xFFFFA500);

  // UI Base
  static const Color panel = Color(0xFF1C1029);
  static const Color text = Colors.white;
  static const Color muted = Color(0xFFBFA6D9);

  // 🔥 Colores neon usados en HomePage
  static const Color neonFuchsia = Color(0xFFF000FF);
  static const Color neonBlue = Color(0xFF00E5FF);
  static const Color neonPurple = Color(0xFF8A2BE2);
  static const Color neonCyan = Color(0xFF00FFFF);
}

class AppTheme {
  static ThemeData get darkNeon => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accentBlue,
      surface: AppColors.card,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),

    cardTheme: const CardThemeData(
      color: AppColors.card,
      elevation: 6,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, color: AppColors.text),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.muted),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
