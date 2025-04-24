import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Không cho tạo instance
class AppTheme {
  AppTheme._();

  /// 1. ColorScheme từ seed (Material 3 tự sinh palette)
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: AppColors.accent,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.accent,
    brightness: Brightness.dark,
  );

  // /// 2. Hoặc khai báo thủ công nếu muốn ép sát mockup hơn:
  // static const ColorScheme lightSchemeManual = ColorScheme(
  //   brightness: Brightness.light,
  //   primary: AppColors.accent,
  //   onPrimary: Colors.white,
  //   secondary: AppColors.textSecondaryLight,
  //   onSecondary: Colors.white,
  //   tertiary: Color(0xFFFFA726),
  //   onTertiary: Colors.white,
  //   background: Colors.white,
  //   onBackground: AppColors.textPrimaryLight,
  //   surface: Colors.white,
  //   onSurface: AppColors.textPrimaryLight,
  //   error: Color(0xFFB00020),
  //   onError: Colors.white,
  // );
  //
  // static const ColorScheme darkSchemeManual = ColorScheme(
  //   brightness: Brightness.dark,
  //   primary: AppColors.accent,
  //   onPrimary: Colors.black,
  //   secondary: AppColors.textSecondaryDark,
  //   onSecondary: Colors.black,
  //   tertiary: Color(0xFFFFA726),
  //   onTertiary: Colors.black,
  //   background: Color(0xFF121212),
  //   onBackground: AppColors.textPrimaryDark,
  //   surface: Color(0xFF1E1E1E),
  //   onSurface: AppColors.textPrimaryDark,
  //   error: Color(0xFFCF6679),
  //   onError: Colors.black,
  // );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightScheme, // hoặc lightSchemeManual
    scaffoldBackgroundColor: _lightScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: _lightScheme.onSurface,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: _lightScheme.onSurface,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: _lightScheme.surface,
      selectedItemColor: _lightScheme.primary,
      unselectedItemColor: _lightScheme.onSurface.withValues(alpha: 0.6),
    ),
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: _lightScheme.primary,
      primaryColorLight: _lightScheme.primary.withValues(alpha: 0.5),
      primaryColorDark: _lightScheme.primary,
      valueIndicatorTextStyle: TextStyle(color: _lightScheme.onPrimary),
    ),
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 64 / 57,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 52 / 45,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 44 / 36,
      ),

      // Headline
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 32 / 24,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
      ),

      // Label
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 16 / 11,
      ),
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkScheme, // hoặc darkSchemeManual
    scaffoldBackgroundColor: _darkScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkScheme.surface,
      foregroundColor: _darkScheme.onSurface,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: _darkScheme.surface,
      selectedItemColor: _darkScheme.primary,
      unselectedItemColor: _darkScheme.onSurface.withValues(alpha: 0.6),
    ),
    sliderTheme: SliderThemeData.fromPrimaryColors(
      primaryColor: _darkScheme.primary,
      primaryColorLight: _darkScheme.primary.withValues(alpha: 0.5),
      primaryColorDark: _darkScheme.primary,
      valueIndicatorTextStyle: TextStyle(color: _darkScheme.onPrimary),
    ),
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 64 / 57,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 52 / 45,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 44 / 36,
      ),

      // Headline
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 32 / 24,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
      ),

      // Label
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 16 / 11,
      ),
    ),

  );
}
