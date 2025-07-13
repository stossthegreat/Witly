import 'package:flutter/material.dart';

class AppConstants {
  // Colors - Matching React app exactly
  static const Color primaryColor = Color(0xFF1A1A2E);
  static const Color backgroundColor = Color(0xFF0F0F1F);
  static const Color cardColor = Color(0xFF212134);
  static const Color accentColor = Color(0xFFDA00FF);  // Purple glow
  static const Color purpleGlow = Color(0xFF8B5CF6);   // Purple variants
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA78BFA); // Purple text
  static const Color borderColor = Color(0xFF3B2764);   // Purple border
  
  // Sizes
  static const double defaultPadding = 16.0;
  static const double cardRadius = 20.0;
  static const double buttonRadius = 12.0;
  static const double iconSize = 24.0;
  static const double micButtonSize = 80.0;
  
  // Durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Glassmorphism decoration
  static BoxDecoration get glassEffect => BoxDecoration(
    color: Colors.white.withOpacity(0.1),
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(
      color: Colors.white.withOpacity(0.2),
      width: 1.0,
    ),
  );
  
  // Purple glow decoration  
  static BoxDecoration get purpleGlowEffect => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(buttonRadius),
    boxShadow: [
      BoxShadow(
        color: accentColor.withOpacity(0.5),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
