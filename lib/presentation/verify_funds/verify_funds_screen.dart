import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquipe/presentation/congrats/congrats_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/otp_textfield.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/verify_funds/bloc/verify_funds_bloc.dart';

class VerifyFundsScreen extends StatelessWidget {
  VerifyFundsScreen({super.key});

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
    return BlocProvider(
      create: (context) => VerifyFundsBloc()..add(VerifyFundsInitialEvent()),
      child: BlocBuilder<VerifyFundsBloc, VerifyFundsState>(
        builder: (context, state) {
          return (state is! VerifyFundsLoading) ? AppScreenTemplate(
            isAuthScreen: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  50 * widthRatio, 40 * heightRatio, 50 * widthRatio, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PoppinsText(
                      text: "Enter Otp to hold funds & unlock cash",
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 75 * heightRatio,
                  ),
                  Row(
                    children: [
                      const PoppinsText(
                          text: "Enter received OTP from ", fontSize: 13),
                      Image.asset(
                        "assets/images/cams.png",
                        width: 45 * widthRatio,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10 * heightRatio,
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
                  SizedBox(
                    height: 10 * heightRatio,
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
                  SizedBox(
                    height: 130 * heightRatio,
                  ),
                  const Center(
                    child: PoppinsText(
                      text: "You will always remain owner of your funds",
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 8 * heightRatio,
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
                        Navigator.pushAndRemoveUntil(context,
                            fadeScreenTransition(const CongratsScreen()), (route) => route.isFirst);
                      },
                      text: "Verify")
                ],
              ),
            ),
          ) : SafeArea(
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 280 * widthRatio,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircularProgressIndicator(),
                      PoppinsText(text: "Securely holding your funds with SEBI registered entities", fontSize: 20, fontWeight: FontWeight.w500,)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
