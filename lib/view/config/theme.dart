import 'package:flutter/material.dart';

final ThemeData davidLynchTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF1E1B29), // Deep Dark Purple-Black
  primaryColor: Color(0xFF8F2D56), // Moody Magenta
  secondaryHeaderColor: Color(0xFF2C233A), // Darker Purple-Black
  appBarTheme: AppBarTheme(
    color: Color(0xFF1E1B29), // Same as background (dreamy)
    elevation: 0,
    titleTextStyle: TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE6E6FA), // Lavender white
    ),
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE6E6FA)), // Dreamlike Lavender

    headlineSmall: TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE6E6FA)),

    bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFE6E6FA)),

    bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF9F1C)), // Neon Orange for contrast

    bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFFB0A8BA)), // Muted Lilac Grey
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1B29), // Blends into dark mood
    selectedItemColor: Color(0xFFFF9F1C), // Neon Orange Highlight
    unselectedItemColor: Color(0xFFB0A8BA), // Muted Lilac Grey
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF8F2D56), // Magenta for Lynchian contrast
    foregroundColor: Color(0xFFE6E6FA), // Light ethereal text/icon
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2C233A), // Slightly lighter dark
    hintStyle: TextStyle(color: Color(0xFFB0A8BA)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF8F2D56)), // Magenta
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFF9F1C)), // Neon Orange
    ),
  ),
);

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light, // Ensure a light dreamy theme
  scaffoldBackgroundColor: Color(0xFFE6E9F0), // Misty Light Blue-Gray
  primaryColor: Color(0xFFA69CAC), // Muted Lavender
  secondaryHeaderColor: Color(0xFFD4C1EC), // Faded Orchid
  hintColor: Color(0xFFFCEEB5), // Faint Sunlight Gold for highlights

  /// **App Bar Theme (Soft, Low Contrast)**
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFE6E9F0), // Soft Foggy Blue
    elevation: 1,
    shadowColor: Color(0xFFD4C1EC).withOpacity(0.3), // Gentle shadow
    titleTextStyle: TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: Color(0xFF3A3A3A), // Soft dark for balance
    ),
    iconTheme: IconThemeData(color: Color(0xFF3A3A3A)),
  ),

  /// **Text Theme (Dreamy, Minimal, Ethereal)**
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: Color(0xFF3A3A3A), // Soft Dark (Balanced)
    ),
    headlineSmall: TextStyle(
      fontFamily: 'SpaceGrotesk',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color(0xFF3A3A3A),
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color(0xFF3A3A3A),
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color(0xFFA69CAC), // Muted Lavender Text
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color(0xFFD4C1EC), // Light Orchid Accent
    ),
  ),

  /// **Bottom Navigation Bar (Subtle, Dreamlike)**
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFE6E9F0),
    selectedItemColor: Color(0xFFA69CAC), // Lavender
    unselectedItemColor: Color(0xFFD4C1EC), // Light Orchid
    selectedLabelStyle: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 14),
    unselectedLabelStyle: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 12),
  ),

  /// **Floating Action Button (Ethereal Glow)**
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFA69CAC),
    foregroundColor: Colors.white,
    elevation: 2,
  ),

  /// **Card Theme (Soft, Airy, Floating)**
  cardTheme: CardTheme(
    color: Color(0xFFF7F7F7), // Gentle Cloud White
    elevation: 3,
    shadowColor: Color(0xFFD4C1EC).withOpacity(0.3), // Soft glow effect
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(16), // More rounded for dreamlike feel
    ),
  ),
);
