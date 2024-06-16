import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/presentation/dashboard/dashboard_screen.dart';
import 'package:liquipe/presentation/statement/bloc/statement_bloc.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFCFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                30 * widthRatio, 30 * heightRatio, 30 * widthRatio, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset("assets/icons/back-arrow.svg"),
                SizedBox(
                  height: 12 * heightRatio,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6 * widthRatio),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PoppinsText(
                        text: "Key Fact Statement",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 25 * heightRatio,
                      ),
                      BlocProvider(
                        create: (context) =>
                            StatementBloc()..add(const StatementLoadEvent()),
                        child: BlocConsumer<StatementBloc, StatementState>(
                          listener: (context, state) {
                            if (state is StatementError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return state is StatementLoaded
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(1, 1),
                                          blurRadius: 10,
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          offset: const Offset(-1, -1),
                                          blurRadius: 10,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: const Color(0xFFE9E9E9),
                                          width: 1),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20 * widthRatio,
                                              20 * heightRatio,
                                              20 * widthRatio,
                                              7 * heightRatio),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const PoppinsText(
                                                text: "Bank Details",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Transform.rotate(
                                                  angle: math.pi / 2,
                                                  child: const Icon(
                                                    Icons
                                                        .arrow_back_ios_rounded,
                                                    color:
                                                        AppTheme.primaryColor,
                                                    size: 30,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Color(0xFFE9E9E9),
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20 * widthRatio,
                                            vertical: 7 * heightRatio,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const PoppinsText(
                                                text: "Loan Amount",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF7C7C7C),
                                              ),
                                              PoppinsText(
                                                text: "INR ${state.loanAmount}",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Color(0xFFE9E9E9),
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20 * widthRatio,
                                            vertical: 7 * heightRatio,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              PoppinsText(
                                                text: "Interest Rate",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF7C7C7C),
                                              ),
                                              PoppinsText(
                                                text: "10.5%",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Color(0xFFE9E9E9),
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20 * widthRatio,
                                            vertical: 7 * heightRatio,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const Column(
                                                children: [
                                                  PoppinsText(
                                                    text:
                                                        "Total interest charge during",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF7C7C7C),
                                                  ),
                                                  PoppinsText(
                                                    text:
                                                        "the entire tenure of the loan",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF7C7C7C),
                                                  ),
                                                ],
                                              ),
                                              PoppinsText(
                                                text:
                                                    "INR ${state.loanAmount * 0.105 * 3}",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Color(0xFFE9E9E9),
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            20 * widthRatio,
                                            7 * heightRatio,
                                            20 * widthRatio,
                                            20 * heightRatio,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              PoppinsText(
                                                text: "Processing Fees",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF7C7C7C),
                                              ),
                                              PoppinsText(
                                                text: "INR 999",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator());
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40 * heightRatio,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(1, 1),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(-1, -1),
                              blurRadius: 10,
                            ),
                          ],
                          border: Border.all(
                              color: const Color(0xFFE9E9E9), width: 1),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  20 * widthRatio,
                                  20 * heightRatio,
                                  20 * widthRatio,
                                  5 * heightRatio),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const PoppinsText(
                                    text: "Specifics",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Transform.rotate(
                                      angle: -math.pi / 2,
                                      child: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: AppTheme.primaryColor,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFE9E9E9),
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20 * widthRatio,
                                vertical: 5 * heightRatio,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 279 * widthRatio,
                                    child: const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: PoppinsText(
                                        overflow: TextOverflow.ellipsis,
                                        text:
                                            "Details about Contingent Charges",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                      angle: -math.pi / 2,
                                      child: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: AppTheme.primaryColor,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFE9E9E9),
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20 * widthRatio,
                                vertical: 5 * heightRatio,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const PoppinsText(
                                    text: "Other Details",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Transform.rotate(
                                      angle: -math.pi / 2,
                                      child: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: AppTheme.primaryColor,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFE9E9E9),
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  20 * widthRatio,
                                  5 * heightRatio,
                                  20 * widthRatio,
                                  20 * heightRatio),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const PoppinsText(
                                    text: "Repayment Schedule",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Transform.rotate(
                                      angle: -math.pi / 2,
                                      child: const Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: AppTheme.primaryColor,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20 * heightRatio,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * widthRatio,
                          vertical: 20 * heightRatio,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(1, 1),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(-1, -1),
                              blurRadius: 10,
                            ),
                          ],
                          border: Border.all(
                              color: const Color(0xFFE9E9E9), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const PoppinsText(
                                  text: "Other Details",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                Transform.rotate(
                                    angle: -math.pi / 2,
                                    child: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: AppTheme.primaryColor,
                                      size: 30,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20 * heightRatio,
                            ),
                            const PoppinsText(
                              text: "Authorized Partner",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            const PoppinsText(
                              text:
                                  "The details of the recovery agent authorized to collect on behalf of Bajaj Finance Ltd will be intimated to you at the time of recovery collection.",
                              fontSize: 10,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20 * heightRatio,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15 * widthRatio),
                        child: AppFilledButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  fadeScreenTransition(
                                      const DashboardScreen()));
                            },
                            text: "Agree"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
