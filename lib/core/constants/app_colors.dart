import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Professional Blue
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryLight = Color(0xFF6366F1);
  static const Color primaryVariant = Color(0xFF312E81);

  // Secondary Colors - Elegant Teal
  static const Color secondaryColor = Color(0xFF06B6D4);
  static const Color secondaryDark = Color(0xFF0891B2);
  static const Color secondaryLight = Color(0xFF22D3EE);
  static const Color secondaryVariant = Color(0xFF0E7490);

  // Accent Colors - Soft Purple
  static const Color accentColor = Color(0xFF8B5CF6);
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color accentDark = Color(0xFF7C3AED);

  // Background Colors - Light Theme
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dialogLight = Color(0xFFFFFFFF);

  // Background Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color dialogDark = Color(0xFF2C2C2C);

  // Text Colors - Light Theme
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textDisabledLight = Color(0xFFBDBDBD);
  static const Color textHintLight = Color(0xFF9E9E9E);

  // Text Colors - Dark Theme
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);
  static const Color textDisabledDark = Color(0xFF616161);
  static const Color textHintDark = Color(0xFF757575);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Grey Palette
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF404040);
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF404040);

  // Overlay Colors
  static const Color overlayLight = Color(0x0D000000);
  static const Color overlayDark = Color(0x0DFFFFFF);
  static const Color scrimLight = Color(0x52000000);
  static const Color scrimDark = Color(0x52000000);

  // Skill Category Colors
  static const Color flutterColor = Color(0xFF02569B);
  static const Color androidColor = Color(0xFF3DDC84);
  static const Color dartColor = Color(0xFF0175C2);
  static const Color kotlinColor = Color(0xFF7F52FF);
  static const Color javaColor = Color(0xFFED8B00);
  static const Color firebaseColor = Color(0xFFFFCA28);
  static const Color gitColor = Color(0xFFF05032);

  // Social Media Brand Colors
  static const Color linkedinColor = Color(0xFF0A66C2);
  static const Color githubColor = Color(0xFF171515);
  static const Color twitterColor = Color(0xFF1DA1F2);
  static const Color mediumColor = Color(0xFF000000);
  static const Color stackoverflowColor = Color(0xFFF48024);
  static const Color emailColor = Color(0xFFEA4335);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    primaryLight,
    primaryColor,
    primaryDark,
  ];

  static const List<Color> secondaryGradient = [
    secondaryLight,
    secondaryColor,
    secondaryDark,
  ];

  static const List<Color> accentGradient = [
    accentLight,
    accentColor,
    accentDark,
  ];

  // Professional Gradients
  static const List<Color> heroGradient = [
    Color(0xFF4F46E5),
    Color(0xFF06B6D4),
  ];

  static const List<Color> subtleGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> coolGradient = [
    Color(0xFF06B6D4),
    Color(0xFF22D3EE),
  ];

  static const List<Color> warmGradient = [
    Color(0xFF8B5CF6),
    Color(0xFFA78BFA),
  ];

  static const List<Color> cardGradient = [
    Color(0xFFFAFAFA),
    Color(0xFFFFFFFF),
  ];

  static const List<Color> darkCardGradient = [
    Color(0xFF2C2C2C),
    Color(0xFF1E1E1E),
  ];

  // Accent Colors for Skills/Projects
  static const Color skillBlue = Color(0xFF3B82F6);
  static const Color skillGreen = Color(0xFF10B981);
  static const Color skillPurple = Color(0xFF8B5CF6);
  static const Color skillOrange = Color(0xFFF59E0B);
  static const Color skillPink = Color(0xFFEC4899);
  static const Color skillTeal = Color(0xFF14B8A6);

  // Shimmer Colors
  static const Color shimmerBaseLight = Color(0xFFE0E0E0);
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2C2C2C);
  static const Color shimmerHighlightDark = Color(0xFF404040);

  // Helper methods for getting theme-based colors
  static Color getTextPrimary(bool isDark) {
    return isDark ? textPrimaryDark : textPrimaryLight;
  }

  static Color getTextSecondary(bool isDark) {
    return isDark ? textSecondaryDark : textSecondaryLight;
  }

  static Color getBackground(bool isDark) {
    return isDark ? backgroundDark : backgroundLight;
  }

  static Color getSurface(bool isDark) {
    return isDark ? surfaceDark : surfaceLight;
  }

  static Color getCard(bool isDark) {
    return isDark ? cardDark : cardLight;
  }

  static Color getBorder(bool isDark) {
    return isDark ? borderDark : borderLight;
  }

  static Color getDivider(bool isDark) {
    return isDark ? dividerDark : dividerLight;
  }

  static Color getShimmerBase(bool isDark) {
    return isDark ? shimmerBaseDark : shimmerBaseLight;
  }

  static Color getShimmerHighlight(bool isDark) {
    return isDark ? shimmerHighlightDark : shimmerHighlightLight;
  }

  // Material Color Swatch for primary color
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
