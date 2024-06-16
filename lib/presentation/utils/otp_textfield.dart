import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextfield extends StatelessWidget {
  const OtpTextfield(
      {super.key,
      required this.digitController,
      this.selfFocusNode,
      this.nextFocusNode});
  final TextEditingController digitController;
  final FocusNode? selfFocusNode;
  final FocusNode? nextFocusNode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 60,
      child: MediaQuery.withNoTextScaling(
        child: TextField(
          controller: digitController,
          focusNode: selfFocusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xFFDFDFDF),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Color(0xFFDFDFDF),
                width: 2,
              ),
            ),
          ),
          onChanged: (value) {
            if (nextFocusNode != null) {
              if (value.isNotEmpty) {
                nextFocusNode?.requestFocus();
              }
            }
          },
        ),
      ),
    );
  }
}
