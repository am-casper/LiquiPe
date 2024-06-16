import 'package:flutter/material.dart';
import 'package:liquipe/presentation/pledge/pledge_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/otp_textfield.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/utils/shadow_container.dart';

class VerifyKycScreen extends StatelessWidget {
  VerifyKycScreen({super.key});

  final TextEditingController digit1Controller = TextEditingController();
  final TextEditingController digit2Controller = TextEditingController();
  final TextEditingController digit3Controller = TextEditingController();
  final TextEditingController digit4Controller = TextEditingController();
  final TextEditingController digit5Controller = TextEditingController();
  final TextEditingController digit6Controller = TextEditingController();
  final FocusNode digit2FocusNode = FocusNode();
  final FocusNode digit3FocusNode = FocusNode();
  final FocusNode digit4FocusNode = FocusNode();
  final FocusNode digit5FocusNode = FocusNode();
  final FocusNode digit6FocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
        isAuthScreen: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 50 * widthRatio, vertical: 40 * heightRatio),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PoppinsText(
                  text: "Verify Otp",
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              Container(
                padding: EdgeInsets.symmetric(vertical: 24 * heightRatio),
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 110 * heightRatio,
                    ),
                    const ShadowContainer(icon: "KYC", isBigIcon: true),
                    Positioned(
                      left: 200 * widthRatio,
                      top: 39 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Pledge", isBigIcon: false),
                    ),
                    Positioned(
                      left: 230 * widthRatio,
                      top: 54 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Sign eAgreement", isBigIcon: false),
                    ),
                    Positioned(
                      left: 257 * widthRatio,
                      top: 72 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Setup Auto-debit", isBigIcon: false),
                    ),
                    Positioned(
                      right: 200 * widthRatio,
                      top: 39 * heightRatio,
                      child: const ShadowContainer(
                          icon: "portfolio", isBigIcon: false),
                    ),
                    Positioned(
                        top: 82 * heightRatio,
                        child: const PoppinsText(text: "2/5"))
                  ],
                ),
              ),
              SizedBox(
                height: 70 * heightRatio,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PoppinsText(
                      text: "Enter received OTP on registered mobile number",
                      fontSize: 12),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpTextfield(
                          digitController: digit1Controller,
                          nextFocusNode: digit2FocusNode,
                        ),
                        OtpTextfield(
                          digitController: digit2Controller,
                          nextFocusNode: digit3FocusNode,
                          selfFocusNode: digit2FocusNode,
                        ),
                        OtpTextfield(
                          digitController: digit3Controller,
                          nextFocusNode: digit4FocusNode,
                          selfFocusNode: digit3FocusNode,
                        ),
                        OtpTextfield(
                          digitController: digit4Controller,
                          nextFocusNode: digit5FocusNode,
                          selfFocusNode: digit4FocusNode,
                        ),
                        OtpTextfield(
                          digitController: digit5Controller,
                          nextFocusNode: digit6FocusNode,
                          selfFocusNode: digit5FocusNode,
                        ),
                        OtpTextfield(
                          digitController: digit6Controller,
                          selfFocusNode: digit6FocusNode,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: PoppinsText(
                      decoration: TextDecoration.underline,
                      text: "Resend OTP",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60 * heightRatio,
              ),
              AppFilledButton(
                  onPressed: () {
                    if (digit1Controller.text.isEmpty ||
                        digit2Controller.text.isEmpty ||
                        digit3Controller.text.isEmpty ||
                        digit4Controller.text.isEmpty ||
                        digit5Controller.text.isEmpty ||
                        digit6Controller.text.isEmpty) {
                      SnackBar snackBar = const SnackBar(
                        content: PoppinsText(
                          text: "Please fill the OTP",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                        context, fadeScreenTransition(const PledgeScreen()), (route) => route.isFirst);
                  },
                  text: "Verify")
            ],
          ),
        ));
  }
}
