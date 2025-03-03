import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

IconThemeData iconTheme = const IconThemeData(
  color: Color(0xFFFFD700), // Gold color for all icons
);

ThemeData memorializedMonokaiTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF28261E), // Darker, aged paper background

  // Modify color scheme for washed-out golden tones
  colorScheme: ColorScheme.dark(
    primary: Color(0xFFD4AF37), // Golden color
    secondary: Color(0xFFBDA55D), // Secondary gold
    tertiary: Color(0xFFAA8C55), // Bronze tone
    surface: Color(0xFF2A2A25), // Slightly warm surface
    background: Color(0xFF28261E), // Aged dark background
  ),

  // Washed-out golden memorabilia style text
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.ibmPlexSerif(
      // Changed to serif for vintage feel
      fontSize: 32,
      fontWeight: FontWeight.w300,
      color: Color(0xFFF8E7C3), // Warm, slightly golden off-white
      letterSpacing: 0.5, // Slightly increased spacing for vintage feel
    ),
    headlineSmall: GoogleFonts.ibmPlexSerif(
      fontSize: 22,
      fontWeight: FontWeight.w300,
      color: Color(0xFFF8E7C3),
      letterSpacing: 0.3,
    ),
    bodyLarge: GoogleFonts.ibmPlexSans(
      fontSize: 18,
      fontWeight: FontWeight.w300, // Slightly heavier for aged paper look
      color: Color(0xFFE8DAB2), // Warm, muted color
      letterSpacing: 0.2,
    ),
    bodyMedium: GoogleFonts.ibmPlexSans(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Color(0xFFCFB991), // Washed-out gold
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.ibmPlexSans(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Color(0xFFBDA87C), // Muted golden brown
    ),
  ),

  // Card styling for vintage feel
  cardTheme: CardTheme(
    color: Color(0xFF2A2722), // Slightly warmer than background
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: Color(0xFF3E3A32).withOpacity(0.6), // Subtle vintage border
        width: 1,
      ),
    ),
  ),

  // Icon theme with golden tones
  iconTheme: IconThemeData(
    color: Color(0xFFD4AF37)
        .withOpacity(0.8), // Golden icons with slight transparency
    size: 24,
  ),

  // Button styling
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2A2722),
      foregroundColor: Color(0xFFD4AF37),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Color(0xFFD4AF37).withOpacity(0.4),
          width: 1,
        ),
      ),
    ),
  ),
);

ThemeData monokaiTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF272822), // Monokai Gray

  /// **🔹 Apply IBM Plex Sans for a Clean, Professional Look**
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.ibmPlexSans(
      fontSize: 32,
      fontWeight: FontWeight.w300, // ✅ Soft, elegant, readable
      color: Color(0xFFF8F8F2), // Monokai Off-White
    ),
    headlineSmall: GoogleFonts.ibmPlexSans(
      fontSize: 22,
      fontWeight: FontWeight.w300,
      color: Color(0xFFF8F8F2),
    ),
    bodyLarge: GoogleFonts.manrope(
      fontSize: 18,
      fontWeight: FontWeight.w200, // ✅ Lightweight for smooth UI
      color: Color(0xFFF8F8F2),
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w200,
      color: Color(0xFFA6E22E), // Monokai Green
    ),
    bodySmall: GoogleFonts.overpass(
      fontSize: 14,
      fontWeight: FontWeight.w200,
      color: Color(0xFF66D9EF), // Monokai Blue
    ),
  ),
);
