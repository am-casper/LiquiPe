import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/presentation/review/bloc/review_bloc.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/verify_funds/verify_funds_screen.dart';


class ReviewScreen extends StatelessWidget {
  const ReviewScreen(
      {super.key,
      required this.totalAmount,
      required this.selectedHoldings,
      required this.pledgeAmountList});

  final double totalAmount;
  final List<MutualFundsHoldingsModel> selectedHoldings;
  final List<double> pledgeAmountList;

  @override
  Widget build(BuildContext context) {
    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",
    );
    List<String> formattedPledgeAmountList = pledgeAmountList
        .map((amount) => numberFormatter.format(amount))
        .toList();
    String formattedTotalAmount = numberFormatter.format(totalAmount);
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
        isAuthScreen: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                50 * widthRatio, 40 * heightRatio, 50 * widthRatio, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const PoppinsText(
                    text: "Review Investments",
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
                SizedBox(
                  height: 30 * heightRatio,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.fromLTRB(19 * widthRatio,
                      22 * heightRatio, 24 * widthRatio, 22 * heightRatio),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Hero(
                          tag: "coins",
                          placeholderBuilder: (context, heroSize, child) =>
                              child,
                          child: SvgPicture.asset("assets/images/coins2.svg")),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const PoppinsText(
                            text: "Total Loan Amount",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                const PoppinsText(
                                  text: "INR",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                Transform.translate(
                                  offset: const Offset(0, 4),
                                  child: PoppinsText(
                                    text: " $totalAmount",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 22 * heightRatio,
                ),
                Column(
                  children: [
                    ...List.generate(selectedHoldings.length, (index) {
                      MutualFundsHoldingsModel holding =
                          selectedHoldings[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20 * heightRatio),
                        padding: EdgeInsets.symmetric(
                            horizontal: 18 * widthRatio,
                            vertical: 18 * heightRatio),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B39F4).withOpacity(0.25),
                              offset: const Offset(1, 1),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: const Color(0xFF6B39F4).withOpacity(0.05),
                              offset: const Offset(-1, -1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  holding.bankLogo,
                                  width: 30 * widthRatio,
                                  height: 30 * heightRatio,
                                ),
                                SizedBox(
                                  width: 5 * widthRatio,
                                ),
                                SizedBox(
                                  width: 150 * widthRatio,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: PoppinsText(
                                          text: holding.bankName,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      PoppinsText(
                                        text:
                                            "Equity . ${holding.equityType == EquityType.cams ? "CAMS" : "KFintech"}",
                                        fontSize: 6,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                const PoppinsText(
                                  text: "Pledge Quantity",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF606060),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6 * widthRatio,
                                      vertical: 2 * heightRatio),
                                  alignment: Alignment.centerRight,
                                  width: 75 * widthRatio,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6B39F4)
                                            .withOpacity(0.25),
                                      ),
                                      const BoxShadow(
                                        color: AppTheme.backgroundColor,
                                        blurRadius: 15.0,
                                      ),
                                    ],
                                  ),
                                  child: PoppinsText(
                                    text: formattedPledgeAmountList[index],
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
                SizedBox(
                  height: 20 * heightRatio,
                ),
                const PoppinsText(
                  text: "Lender Information",
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10 * heightRatio,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 18 * widthRatio, vertical: 18 * heightRatio),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B39F4).withOpacity(0.25),
                        offset: const Offset(1, 1),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: const Color(0xFF6B39F4).withOpacity(0.05),
                        offset: const Offset(-1, -1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/icici.png",
                            width: 30 * widthRatio,
                            height: 30 * heightRatio,
                          ),
                          SizedBox(
                            width: 5 * widthRatio,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: 150 * widthRatio,
                              child: const PoppinsText(
                                text: "ICICI Bank",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const PoppinsText(
                            text: "Loan Amount",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF606060),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6 * widthRatio,
                                vertical: 2 * heightRatio),
                            alignment: Alignment.centerRight,
                            width: 75 * widthRatio,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF6B39F4).withOpacity(0.25),
                                ),
                                const BoxShadow(
                                  color: AppTheme.backgroundColor,
                                  blurRadius: 15.0,
                                ),
                              ],
                            ),
                            child: PoppinsText(
                              text: formattedTotalAmount,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100 * heightRatio,
                ),
                const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PoppinsText(
                        text: "Our Promise",
                        fontSize: 10,
                        color: Color(0xFF858585),
                      ),
                      PoppinsText(
                        text: "100% Security of your investments",
                        fontSize: 10,
                        color: Color(0xFF858585),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120 * heightRatio,
                ),
                BlocProvider(
                  create: (context) => ReviewBloc(),
                  child: BlocConsumer<ReviewBloc, ReviewState>(
                    listener: (context, state) {
                      if (state is ReviewSuccess) {
                        Navigator.push(
                            context,
                            fadeScreenTransition(VerifyFundsScreen()),);
                      }
                      if (state is ReviewFailure) {
                        SnackBar snackBar = SnackBar(
                          content: PoppinsText(
                            text: state.error,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) => GestureDetector(
                      onTap: () {
                        context
                            .read<ReviewBloc>()
                            .add(ReviewSubmitEvent(loanAmount: totalAmount));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: AppTheme.primaryColor, width: 3),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12 * heightRatio),
                        child: const Center(
                          child: PoppinsText(
                            text: "Unlock Cash",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
