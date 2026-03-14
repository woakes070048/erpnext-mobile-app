import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark() {
    const primary = Color(0xFFAFC6FF);
    const onPrimary = Color(0xFF082B62);
    const primaryContainer = Color(0xFF213B6A);
    const onPrimaryContainer = Color(0xFFDCE7FF);
    const secondary = Color(0xFFBEC7D8);
    const onSecondary = Color(0xFF273140);
    const tertiary = Color(0xFF93D5BE);
    const onTertiary = Color(0xFF063828);
    const canvas = Color(0xFF0E1117);
    const surface = Color(0xFF11141A);
    const surfaceDim = Color(0xFF161B23);
    const surfaceBright = Color(0xFF1B222C);
    const outline = Color(0xFF3C4758);
    const ink = Color(0xFFE7EAF0);
    const muted = Color(0xFFADB5C3);

    final textTheme = _textTheme(ink: ink, muted: muted);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: const Color(0xFF2A3442),
      onSecondaryContainer: const Color(0xFFDDE4F2),
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: const Color(0xFF154937),
      onTertiaryContainer: const Color(0xFFB3EED8),
      surface: surface,
      onSurface: ink,
      surfaceDim: canvas,
      surfaceBright: surfaceBright,
      surfaceContainerLowest: const Color(0xFF0B0E13),
      surfaceContainerLow: surface,
      surfaceContainer: surfaceDim,
      surfaceContainerHigh: surfaceBright,
      surfaceContainerHighest: const Color(0xFF242C37),
      outline: outline,
      outlineVariant: const Color(0xFF2C3440),
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      cardColor: surfaceDim,
      dividerColor: colorScheme.outlineVariant,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: const Color(0xFF334055),
          disabledForegroundColor: const Color(0xFF8B97AA),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceBright,
        selectedColor: primaryContainer,
        secondarySelectedColor: primaryContainer,
        disabledColor: surface,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        labelStyle: textTheme.bodyMedium!,
        secondaryLabelStyle: textTheme.bodyMedium!.copyWith(
          color: onPrimaryContainer,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: outline),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: surfaceBright,
        hintColor: muted,
        focusColor: primary,
        enabledBorderColor: outline,
        textColor: ink,
      ),
    );
  }

  static ThemeData light() {
    const primary = Color(0xFF355CA8);
    const onPrimary = Color(0xFFFFFFFF);
    const primaryContainer = Color(0xFFD9E3F8);
    const onPrimaryContainer = Color(0xFF0D2F67);
    const secondary = Color(0xFF5A6473);
    const onSecondary = Color(0xFFFFFFFF);
    const tertiary = Color(0xFF35685A);
    const onTertiary = Color(0xFFFFFFFF);
    const canvas = Color(0xFFFCFBF8);
    const surface = Color(0xFFF7F6F2);
    const surfaceDim = Color(0xFFF0EEE8);
    const surfaceBright = Color(0xFFFFFFFF);
    const outline = Color(0xFFC8C5BC);
    const ink = Color(0xFF171C24);
    const muted = Color(0xFF5C6472);

    final textTheme = _textTheme(ink: ink, muted: muted);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: const Color(0xFFDDE3EE),
      onSecondaryContainer: const Color(0xFF131C2B),
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: const Color(0xFFC2E9DA),
      onTertiaryContainer: const Color(0xFF133C31),
      surface: surface,
      onSurface: ink,
      surfaceDim: const Color(0xFFE9E6DD),
      surfaceBright: surfaceBright,
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: surfaceBright,
      surfaceContainer: surfaceDim,
      surfaceContainerHigh: const Color(0xFFE7E4DB),
      surfaceContainerHighest: const Color(0xFFDFDBD2),
      outline: outline,
      outlineVariant: const Color(0xFFD8D4CB),
      error: const Color(0xFFBA1A1A),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvas,
      cardColor: surfaceBright,
      dividerColor: colorScheme.outlineVariant,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: const Color(0xFFD6DBE4),
          disabledForegroundColor: const Color(0xFF7F8794),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceDim,
        selectedColor: primaryContainer,
        secondarySelectedColor: primaryContainer,
        disabledColor: surface,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        labelStyle: textTheme.bodyMedium!,
        secondaryLabelStyle: textTheme.bodyMedium!.copyWith(
          color: onPrimaryContainer,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: outline),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme(
        fillColor: surfaceBright,
        hintColor: muted,
        focusColor: primary,
        enabledBorderColor: outline,
        textColor: ink,
      ),
    );
  }

  static TextTheme _textTheme({
    required Color ink,
    required Color muted,
  }) {
    return TextTheme(
      displaySmall: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ink,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: muted,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color hintColor,
    required Color focusColor,
    required Color enabledBorderColor,
    required Color textColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      labelStyle: GoogleFonts.inter(
        color: hintColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      hintStyle: GoogleFonts.inter(
        color: hintColor,
        fontSize: 15,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: enabledBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: focusColor, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      prefixIconColor: textColor,
    );
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color shellStart(BuildContext context) =>
      isDark(context) ? const Color(0xFF0A0D13) : const Color(0xFFFDFBF7);

  static Color shellEnd(BuildContext context) =>
      isDark(context) ? const Color(0xFF151A22) : const Color(0xFFF3F1EA);

  static Color cardBackground(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLow;

  static Color cardBorder(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant;

  static Color actionSurface(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  static Color dockDivider(BuildContext context) =>
      Theme.of(context).colorScheme.outlineVariant;

  static Color dockInactive(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHigh;

  static Color dockActive(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;

  static Color primaryButton(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color primaryButtonForeground(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;
}
