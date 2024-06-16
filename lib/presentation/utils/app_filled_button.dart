import 'package:flutter/material.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton(
      {super.key, this.onPressed, required this.text, this.color});
  final Function()? onPressed;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: 44 * widthRatio, vertical: 12 * heightRatio),
        decoration: BoxDecoration(
          color: color ?? AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: PoppinsText(
          textAlign: TextAlign.center,
          text: text,
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
