import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontSize {
  large,
  medium,
  small,
  extraSmall,
}

enum FontFamily {
  openSans,
  roboto,
  titilliumWeb,
}

Widget text(
    {required String text,
    double? size,
    FontFamily? fontFamily,
    Color? colour = Colors.black87,
    FontWeight? fontWeight,
    FontSize? sizeType}) {
  switch (sizeType) {
    case FontSize.large:
      size = 75.sp;
      break;
    case FontSize.medium:
      size = 55.sp;
      break;
    case FontSize.small:
      size = 50.sp;
      break;
    case FontSize.extraSmall:
      size = 45.sp;
      break;
    case null:
      size ??= 55.sp;
      break;
  }

  if (fontFamily == FontFamily.openSans) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: size, color: colour, fontWeight: fontWeight),
    );
  } else if (fontFamily == FontFamily.titilliumWeb) {
    return Text(
      text,
      style: GoogleFonts.titilliumWeb(
        fontSize: size,
        color: colour,
        fontWeight: fontWeight,
      ),
    );
  } else {
    return Text(
      text,
      style: GoogleFonts.roboto(
          fontSize: size, color: colour, fontWeight: fontWeight),
    );
  }
}
