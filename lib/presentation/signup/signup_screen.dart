import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/verify_otp/verify_otp_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightRatio = MediaQuery.of(context).size.height / 932;
    double widthRatio = MediaQuery.of(context).size.width / 430;
    return AppScreenTemplate(
      isAuthScreen: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 44 * widthRatio, vertical: 70 * heightRatio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "signUp",
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return DefaultTextStyle(
                  style: DefaultTextStyle.of(fromHeroContext).style,
                  child: Wrap(children: [toHeroContext.widget]),
                );
              },
              child: const Material(
                type: MaterialType.transparency,
                child: Row(
                  children: [
                    PoppinsText(
                      text: "Sign ",
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                    PoppinsText(
                      text: "Up",
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 62 * heightRatio,
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: const Color(0xFFDFDFDF), width: 2),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/flag.svg"),
                                const SizedBox(
                                  width: 4,
                                ),
                                const PoppinsText(text: "+91"),
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                      color: Color(0xFFDFDFDF), thickness: 2),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 150,
                                  child: MediaQuery.withNoTextScaling(
                                    child: TextField(
                                      controller: controller,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: GoogleFonts.poppins()),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: -4,
                      child: Container(
                        color: Colors.white,
                        child: const PoppinsText(
                          text: "Contact Number",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40 * heightRatio,
                ),
                AppFilledButton(
                    onPressed: () {
                      if (controller.text.length != 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: PoppinsText(
                              text: "Invalid contact number",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                        return; 
                      }
                      Navigator.push(
                        context,
                        fadeScreenTransition(VerifyOtpScreen()),
                      );
                    },
                    text: "Continue"),
                SizedBox(
                  height: 40 * heightRatio,
                ),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD0D0D0),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: PoppinsText(
                          text: "or",
                          fontSize: 16,
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD0D0D0),
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40 * heightRatio,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const PoppinsText(
                    decoration: TextDecoration.underline,
                    textAlign: TextAlign.center,
                    text: "Sign Up with email",
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 55 * heightRatio,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const PoppinsText(
                      text: "Already have an account?",
                      fontSize: 16,
                      color: Color(0xFF8A8A8A),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const PoppinsText(
                        text: " Login",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
