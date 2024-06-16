import 'package:flutter/material.dart';
import 'package:liquipe/presentation/statement/statement_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/app_textfield.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:lottie/lottie.dart';

class BankDetailsFormScreen extends StatelessWidget {
  BankDetailsFormScreen({super.key});
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accNoController = TextEditingController();
  final TextEditingController _confirmAccNoController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
      isAuthScreen: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 50 * widthRatio, vertical: 55 * heightRatio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const PoppinsText(
              text: "Bank Details",
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 90 * heightRatio,
            ),
            Column(
              children: <Widget>[
                AppTextfield(
                    labelText: "Bank", textController: _bankNameController),
                AppTextfield(
                    labelText: "Account Number",
                    textController: _accNoController,
                    keyboardType: TextInputType.phone),
                AppTextfield(
                    labelText: "Re-enter Account Number",
                    textController: _confirmAccNoController,
                    keyboardType: TextInputType.phone),
                AppTextfield(
                    labelText: "IFSC Code",
                    textController: _ifscController,),
              ],
            ),
            SizedBox(
              height: 63 * heightRatio,
            ),
            AppFilledButton(
                onPressed: () {
                  if (_bankNameController.text.isEmpty ||
                      _accNoController.text.isEmpty ||
                      _confirmAccNoController.text.isEmpty ||
                      _ifscController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                    return;
                  }
                  if (_accNoController.text != _confirmAccNoController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account numbers do not match"),
                      ),
                    );
                    return;
                  }
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) {
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(ctx).pop(); // Close the dialog
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx1) {
                            double dialogWidthRatio =
                                MediaQuery.of(ctx1).size.width / 368;
                            double dialogHeightRatio =
                                MediaQuery.of(ctx1).size.width / 400;
                            return PopScope(
                              canPop: false,
                              child: AlertDialog(
                                title: Center(
                                  child: Lottie.asset(
                                      "assets/gifs/congrats.json",
                                      height: 100 * dialogHeightRatio),
                                ),
                                content: SizedBox(
                                  height: 180 * dialogHeightRatio,
                                  child: Column(
                                    children: <Widget>[
                                      const PoppinsText(
                                        text: "Autopay setup successful",
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        height: 10 * dialogHeightRatio,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25 * dialogWidthRatio),
                                        child: const PoppinsText(
                                          text:
                                              "Thank you for your patience. Your autopay has has been successfully steup.",
                                          fontSize: 10,
                                          color: Color(0xFF858585),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10 * dialogWidthRatio),
                                        child: const PoppinsText(
                                          text:
                                              "You will be automatically redirected to the: next step in a few seconds",
                                          fontSize: 10,
                                          color: Color(0xFF858585),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35 * dialogHeightRatio,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5 * dialogWidthRatio),
                                        child: AppFilledButton(
                                          onPressed: () {
                                            Navigator.of(ctx1).pop();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              fadeScreenTransition(
                                                  const StatementScreen()),
                                              (route) => route.isFirst,
                                            );
                                          },
                                          text: "Continue",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        );
                      });
                      return PopScope(
                        canPop: false,
                        child: AlertDialog(
                          title: Center(
                            child: Lottie.asset("assets/gifs/coins.json",
                                width: 92),
                          ),
                          content: SizedBox(
                            height: 165 * heightRatio,
                            child: Column(
                              children: <Widget>[
                                const PoppinsText(
                                  text: "Depositing rupee 1",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 34 * heightRatio,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10 * widthRatio),
                                  child: const PoppinsText(
                                    text:
                                        "To verify the bank account we will deposit 21 and match account holder name with name as per PAN",
                                    fontSize: 10,
                                    color: Color(0xFF858585),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 34 * heightRatio,
                                ),
                                const PoppinsText(
                                  text: "This may take up 30 seconds",
                                  fontSize: 10,
                                  color: Color(0xFF858585),
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  );
                },
                text: "Continue")
          ],
        ),
      ),
    );
  }
}
