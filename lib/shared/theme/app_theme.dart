import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TWAppTheme {
  const TWAppTheme();

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme,
    );
  }

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      surface: Color(0xff121212),
      primary: Color(0xff9898ff),
      onPrimary: Color(0xffffffff),
      secondary: Color(0xff8d8585),
      onSecondary: Color(0xff85d7fc),
      tertiary: Color(0xff293236),
      onTertiary: Color(0xff6a8f98),
      error:  Color(0xfffd4141),
      onError: Color(0xffffffff),
      onSurface: Color(0xffffffff),
      brightness: Brightness.light

    );
  }

  static TextTheme get _textTheme {
    const textTheme = TextTheme();

    final bodyFont = GoogleFonts.poppinsTextTheme(textTheme);
    final headingFont = GoogleFonts.poppinsTextTheme(textTheme);

    return bodyFont.copyWith(
      displayLarge: headingFont.displayLarge,
      displayMedium: headingFont.displayMedium,
      displaySmall: headingFont.displaySmall,
      headlineLarge: headingFont.headlineLarge,
      headlineMedium: headingFont.headlineMedium,
      headlineSmall: headingFont.headlineSmall,
      bodyLarge: bodyFont.bodyLarge,
      bodyMedium: bodyFont.bodyMedium,
      bodySmall: bodyFont.bodySmall,
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: _colorScheme.surface,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      disabledBorder: _disabledBorder,
    );
  }

  static FilledButtonThemeData get _filledButtonTheme {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  static InputBorder get _enabledBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.transparent),
  );

  static InputBorder get _focusedBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide.none,
  );

  static InputBorder get _disabledBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
  );
}