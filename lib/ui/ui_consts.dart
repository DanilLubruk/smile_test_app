import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiConsts {
  static const double galleryHeight = 300;
  static const double cardImageSize = 100;
  static const double screenPadding = 16;
  static const double cardElevation = 10;

  static const double listItemTitleTextSize = 16;
  static const double headerTextSize = 24;

  static final headerTextStyle = GoogleFonts.lora(
      fontSize: UiConsts.headerTextSize, fontWeight: FontWeight.bold);

  static final listItemTitleTextStyle = GoogleFonts.lora(
      fontSize: UiConsts.listItemTitleTextSize, fontWeight: FontWeight.bold);
}
