import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    scaffoldBackgroundColor: Colors.grey.shade50,
    fontFamily: GoogleFonts.openSans().fontFamily,
    cardTheme: CardTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    listTileTheme: ListTileThemeData(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
    searchBarTheme: const SearchBarThemeData(
      elevation: WidgetStatePropertyAll(0.3),
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      titleLarge:
          GoogleFonts.openSans(fontSize: 19, fontWeight: FontWeight.w500),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
    scaffoldBackgroundColor: Colors.grey[900],
    fontFamily: GoogleFonts.openSans().fontFamily,
    cardTheme: CardTheme(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[850],
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    listTileTheme: ListTileThemeData(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Colors.white70, width: 0.5),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
    searchBarTheme: const SearchBarThemeData(
      elevation: WidgetStatePropertyAll(0.3),
    ),
    textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme)
        .copyWith(
      titleLarge:
          GoogleFonts.openSans(fontSize: 19, fontWeight: FontWeight.w500),
    ),
  );
}
