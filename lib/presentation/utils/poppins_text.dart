import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;

  const PoppinsText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign,
      this.decoration,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withNoTextScaling(
      child: Text(
        text,
        softWrap: overflow == null ? true : false,
        overflow: overflow ,
        style: GoogleFonts.poppins(
            fontSize:
                (fontSize ?? 14) * MediaQuery.of(context).size.width / 430,
            fontWeight: fontWeight,
            color: color,
            decoration: decoration),
        textAlign: textAlign,
      ),
    );
  }
}
