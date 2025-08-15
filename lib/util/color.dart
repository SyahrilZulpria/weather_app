import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color colorPrimary = Color(0xfff4af07);
Color colorAccent = Color(0xff38B6FF);
Color shadow = Color(0x33666666);
Color formHint = Color(0xffB0B3B4);
Color formColorDisabled = Color(0xfff2f2f2);
Color lightGrey = Color(0xffeeeeee);
Color formColor = Color(0xffffffff);
Color formColorGreen = Color(0xffDCF8C6); //green
Color formBorder = Color(0xffdddddd);

const colorPrimary2 = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const defaultPadding = 16.0;

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  );
}
