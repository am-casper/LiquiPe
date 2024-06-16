import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield(
      {super.key,
      required this.labelText,
      this.keyboardType,
      required this.textController});

  final TextEditingController textController;
  final TextInputType? keyboardType;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    double heightRatio = (MediaQuery.of(context).size.height) / 932;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12 * heightRatio),
      child: SizedBox(
        height: 70 * heightRatio,
        child: MediaQuery.withNoTextScaling(
          child: TextField(
            maxLines: null,
            expands: true,
            controller: textController,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              labelText: labelText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60),
                borderSide: const BorderSide(
                  color: Color(0xFFDFDFDF),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(60),
                borderSide: const BorderSide(
                  color: Color(0xFFDFDFDF),
                  width: 2,
                ),
              ),
              labelStyle: GoogleFonts.poppins(
                fontSize: 14 * heightRatio,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: GoogleFonts.poppins(
              fontSize: 14 * heightRatio,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
