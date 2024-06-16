import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquipe/presentation/bank_details_form/bank_details_form_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:lottie/lottie.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFFBFCFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30 * widthRatio, 30 * widthRatio,
              30 * widthRatio, 50 * heightRatio),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset("assets/icons/back-arrow.svg"),
              SizedBox(
                height: 18 * heightRatio,
              ),
              const Center(
                child: PoppinsText(
                  text: "Congratulations!",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 70 * heightRatio,
              ),
              Center(
                child: Lottie.asset('assets/gifs/congrats.json',
                    height: 255 * heightRatio),
              ),
              SizedBox(
                height: 45 * heightRatio,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15 * widthRatio, right: 80 * widthRatio),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10 * widthRatio),
                      child: const PoppinsText(
                        text: "The remaining process takes less than 2 mins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20 * heightRatio,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/final-details.png",
                          height: 230 * heightRatio,
                        ),
                        SizedBox(
                          width: 15 * widthRatio,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4 * heightRatio,
                            ),
                            const PoppinsText(
                              text: "Bank account verification",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const PoppinsText(
                              text:
                                  "Securely link your bank account for hassle free transactions.",
                              fontSize: 6,
                              color: Color(0xFF858585),
                            ),
                            SizedBox(
                              height: 60 * heightRatio,
                            ),
                            const PoppinsText(
                              text: "Sign e-Agreement",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const PoppinsText(
                              text:
                                  "Sign documents electronically with ease and convenience.",
                              fontSize: 6,
                              color: Color(0xFF858585),
                            ),
                            SizedBox(
                              height: 60 * heightRatio,
                            ),
                            const PoppinsText(
                              text: "Setup Auto-debit",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const PoppinsText(
                              text:
                                  "Setup automatic payments for seamless bill management.",
                              fontSize: 6,
                              color: Color(0xFF858585),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35 * heightRatio,
              ),
              AppFilledButton(
                  onPressed: () {
                    Navigator.push(
                        context, fadeScreenTransition(BankDetailsFormScreen()));
                  },
                  text: "Continue")
            ],
          ),
        ),
      ),
    ));
  }
}
