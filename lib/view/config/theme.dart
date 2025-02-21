import 'package:flutter/material.dart';

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
