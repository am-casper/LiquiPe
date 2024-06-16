import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/presentation/pledge/bloc/pledge_bloc.dart';
import 'package:liquipe/presentation/review/review_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/utils/shadow_container.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PledgeScreen extends StatelessWidget {
  const PledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    final numberFormatter = NumberFormat(
      "##,##,###",
      "en_US",
    );
    final limitFormatter =
        NumberFormat.compact(locale: "en_IN", explicitSign: false);
    return BlocProvider(
      create: (context) => PledgeBloc()..add(PledgeInitialEvent()),
      child: AppScreenTemplate(
        isAuthScreen: false,
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  50 * widthRatio, 40 * heightRatio, 50 * widthRatio, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const PoppinsText(
                    text: "Pledge",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
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
                        const ShadowContainer(icon: "Pledge", isBigIcon: true),
                        Positioned(
                          right: 200 * widthRatio,
                          top: 39 * heightRatio,
                          child: const ShadowContainer(
                              icon: "KYC", isBigIcon: false),
                        ),
                        Positioned(
                          left: 200 * widthRatio,
                          top: 39 * heightRatio,
                          child: const ShadowContainer(
                              icon: "Sign eAgreement", isBigIcon: false),
                        ),
                        Positioned(
                          left: 230 * widthRatio,
                          top: 54 * heightRatio,
                          child: const ShadowContainer(
                              icon: "Setup Auto-debit", isBigIcon: false),
                        ),
                        Positioned(
                          right: 230 * widthRatio,
                          top: 54 * heightRatio,
                          child: const ShadowContainer(
                              icon: "portfolio", isBigIcon: false),
                        ),
                        Positioned(
                            top: 82 * heightRatio,
                            child: const PoppinsText(text: "3/5"))
                      ],
                    ),
                  ),
                  Center(
                    child: BlocBuilder<PledgeBloc, PledgeState>(
                      builder: (context, state) {
                        if (state.selectedHoldings.isEmpty) {
                          return FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              height: 210 * heightRatio,
                              width: 1.625 * 200 * heightRatio,
                              // decoration: const BoxDecoration(
                              //   image: DecorationImage(
                              //     image: AssetImage(
                              //       "assets/images/cont.png",
                              //     ),
                              //   ),
                              // ),

                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF6B39F4)
                                        .withOpacity(0.25),
                                    offset: const Offset(1, 1),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF6B39F4)
                                        .withOpacity(0.05),
                                    offset: const Offset(-1, -1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset("assets/images/coins1.svg"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const PoppinsText(
                                    text: "Enter Amount",
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 25 * heightRatio,)
                                ],
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: 210 * heightRatio,
                          width: 1.625 * 200 * heightRatio,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBFCFF),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF6B39F4).withOpacity(0.25),
                                offset: const Offset(1, 1),
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                    const Color(0xFF6B39F4).withOpacity(0.05),
                                offset: const Offset(-1, -1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SfRadialGauge(
                                enableLoadingAnimation: true,
                                axes: [
                                  RadialAxis(
                                    onLabelCreated:
                                        (AxisLabelCreatedArgs args) {
                                      if (args.text == "50") {
                                        String halfAmount = limitFormatter
                                            .format(state.pledgeAmountList
                                                    .reduce((a, b) => a + b) /
                                                2);
                                        if (state.pledgeAmountList
                                                .reduce((a, b) => a + b) <
                                            50000) {
                                          args.text = "";
                                          return;
                                        }
                                        if (halfAmount.endsWith("T")) {
                                          halfAmount =
                                              halfAmount.replaceAll("T", "K");
                                        }
                                        args.text = halfAmount;
                                      }
                                    },
                                    showLabels: true,
                                    showFirstLabel: false,
                                    maximumLabels: 2,
                                    labelsPosition: ElementsPosition.outside,
                                    showTicks: false,
                                    startAngle: 180,
                                    endAngle: 0,
                                    radiusFactor: 1.3,
                                    canScaleToFit: true,
                                    axisLineStyle: AxisLineStyle(
                                      thickness: 0.1,
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.05),
                                      thicknessUnit: GaugeSizeUnit.factor,
                                      cornerStyle: CornerStyle.bothFlat,
                                    ),
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                          value: state.percentagePledged,
                                          width: 0.1,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          cornerStyle: CornerStyle.bothFlat,
                                          color: AppTheme.primaryColor),
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                left: (1.625 * 200 * heightRatio -
                                        130 * heightRatio) /
                                    2,
                                top: 43 * heightRatio,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: "coins",
                                      child: SvgPicture.asset(
                                        "assets/images/coins1.svg",
                                        height: 130 * heightRatio,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -13),
                                      child: PoppinsText(
                                        text: state.pledgeAmountList.reduce((a, b) => a + b) *
                                                    state.percentagePledged /
                                                    100 >=
                                                25000
                                            ? limitFormatter
                                                    .format(state.pledgeAmountList.reduce((a, b) => a + b) *
                                                        state
                                                            .percentagePledged /
                                                        100)
                                                    .endsWith("T")
                                                ? limitFormatter
                                                    .format(state.pledgeAmountList.reduce((a, b) => a + b) *
                                                        state
                                                            .percentagePledged /
                                                        100)
                                                    .replaceAll("T", "K")
                                                : limitFormatter.format(state.pledgeAmountList
                                                        .reduce((a, b) => a + b) *
                                                    state.percentagePledged /
                                                    100)
                                            : "N/A",
                                        decoration: TextDecoration.underline,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15 * heightRatio,
                                left: 20 * widthRatio,
                                child: const PoppinsText(
                                    text: "25K", fontSize: 13),
                              ),
                              Positioned(
                                bottom: 15 * heightRatio,
                                right: 16 * widthRatio,
                                child: PoppinsText(
                                    text: state.pledgeAmountList
                                                .reduce((a, b) => a + b) >
                                            25000
                                        ? limitFormatter
                                                .format(state.pledgeAmountList
                                                    .reduce((a, b) => a + b))
                                                .endsWith("T")
                                            ? limitFormatter
                                                .format(state.pledgeAmountList
                                                    .reduce((a, b) => a + b))
                                                .replaceAll("T", "K")
                                            : limitFormatter.format(state
                                                .pledgeAmountList
                                                .reduce((a, b) => a + b))
                                        : "N/A",
                                    fontSize: 13),
                              ),
                              Positioned(
                                bottom: 7 * heightRatio,
                                left: 50 * heightRatio * 1.625,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<PledgeBloc>().add(
                                        PledgePercentageChangeEvent(
                                            percentage: 50));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: state.percentagePledged == 50
                                          ? AppTheme.primaryColor
                                          : AppTheme.backgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.25),
                                          offset: const Offset(0.1, 0.1),
                                          blurRadius: 1,
                                        ),
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.25),
                                          offset: const Offset(-0.1, -0.1),
                                          blurRadius: 1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: PoppinsText(
                                      text: "50%",
                                      fontSize: 10,
                                      color: state.percentagePledged == 50
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<PledgeBloc>().add(
                                      PledgePercentageChangeEvent(
                                          percentage: 75));
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: 7 * heightRatio),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: state.percentagePledged == 75
                                        ? AppTheme.primaryColor
                                        : AppTheme.backgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.25),
                                        offset: const Offset(0.1, 0.1),
                                        blurRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: AppTheme.primaryColor
                                            .withOpacity(0.25),
                                        offset: const Offset(-0.1, -0.1),
                                        blurRadius: 1,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: PoppinsText(
                                    text: "75%",
                                    fontSize: 10,
                                    color: state.percentagePledged == 75
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 7 * heightRatio,
                                right: 50 * heightRatio * 1.625,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<PledgeBloc>().add(
                                        PledgePercentageChangeEvent(
                                            percentage: 100));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: state.percentagePledged == 100
                                          ? AppTheme.primaryColor
                                          : AppTheme.backgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.25),
                                          offset: const Offset(0.1, 0.1),
                                          blurRadius: 1,
                                        ),
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.25),
                                          offset: const Offset(-0.1, -0.1),
                                          blurRadius: 1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: PoppinsText(
                                      text: "100%",
                                      fontSize: 10,
                                      color: state.percentagePledged == 100
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 28 * heightRatio,
                  ),
                  const PoppinsText(
                    text: "Pledge your mutual funds",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 15 * heightRatio,
                  ),
                  BlocBuilder<PledgeBloc, PledgeState>(
                    builder: (context, state) {
                      if (state.holdings.isEmpty) {
                        return const Center(
                            child: PoppinsText(text: "No Holdings Found"));
                      } else {
                        return Column(
                          children: <Widget>[
                            ...List.generate(state.holdings.length, (index) {
                              MutualFundsHoldingsModel holdingModel =
                                  state.holdings[index];
                              return GestureDetector(
                                onTap: () {
                                  context.read<PledgeBloc>().add(
                                      PledgeSelectHoldingsEvent(
                                          holding: holdingModel, index: index));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppTheme.backgroundColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(state
                                                  .selectedHoldings
                                                  .contains(holdingModel)
                                              ? 0.8
                                              : 0),
                                          width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF6B39F4)
                                              .withOpacity(0.25),
                                          offset: const Offset(1, 1),
                                          blurRadius: 10,
                                        ),
                                        BoxShadow(
                                          color: const Color(0xFF6B39F4)
                                              .withOpacity(0.05),
                                          offset: const Offset(-1, -1),
                                          blurRadius: 10,
                                        ),
                                      ]),
                                  margin: EdgeInsets.only(
                                    bottom: 15 * heightRatio,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15 * widthRatio,
                                      vertical: 15 * heightRatio),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        holdingModel.bankLogo,
                                        height: 30 * heightRatio,
                                      ),
                                      SizedBox(
                                        width: 5 * widthRatio,
                                      ),
                                      SizedBox(
                                        width: 255 * widthRatio,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            PoppinsText(
                                              text: holdingModel.bankName,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            PoppinsText(
                                              text:
                                                  "Equity . ${holdingModel.equityType == EquityType.cams ? "CAMS" : "KFintech"}",
                                              fontSize: 6,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              height: 10 * heightRatio,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const PoppinsText(
                                                      text: "Value",
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    PoppinsText(
                                                      text:
                                                          "INR ${numberFormatter.format(holdingModel.holdingAmount)}",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    const PoppinsText(
                                                      text: "Pledge Amount",
                                                      fontSize: 6,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: 75 * widthRatio,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xFF6B39F4)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                          const BoxShadow(
                                                            color: AppTheme
                                                                .backgroundColor,
                                                            blurRadius: 15.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: MediaQuery
                                                          .withNoTextScaling(
                                                        child: TextField(
                                                          expands: false,
                                                          onChanged: (value) {
                                                            if (double.parse(
                                                                    value) >
                                                                holdingModel
                                                                    .holdingAmount) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      const SnackBar(
                                                                content:
                                                                    PoppinsText(
                                                                  text:
                                                                      "Pledge amount should be less than or equal to holding amount",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ));
                                                            }
                                                            context
                                                                .read<
                                                                    PledgeBloc>()
                                                                .add(PledgeAmountChangeEvent(
                                                                    amount: value
                                                                            .isEmpty
                                                                        ? 0
                                                                        : double.parse(
                                                                            value),
                                                                    index:
                                                                        index));
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            enabled: state
                                                                .selectedHoldings
                                                                .contains(
                                                                    holdingModel),
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    horizontal: 7 *
                                                                        widthRatio,
                                                                    vertical: 2 *
                                                                        heightRatio),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize:
                                                                10 * widthRatio,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20 * heightRatio,
                  ),
                  BlocBuilder<PledgeBloc, PledgeState>(
                    builder: (context, state) {
                      return AppFilledButton(
                          onPressed: () {
                            if (state.selectedHoldings.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: PoppinsText(
                                  text: "Please select a holding to pledge",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ));
                              return;
                            }
                            if (state.pledgeAmountList.reduce((a, b) => a + b) *
                                    state.percentagePledged /
                                    100 <
                                25000) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: PoppinsText(
                                    text:
                                        "Pledge amount should be greater than 25K",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                              return;
                            }

                            final double totalAmount = 
                                state.pledgeAmountList.reduce((a, b) => a + b) *
                                    state.percentagePledged /
                                    100;
                            final List<MutualFundsHoldingsModel>
                                selectedHoldings = state.selectedHoldings;
                            Navigator.push(
                              context,
                              fadeScreenTransition(
                                ReviewScreen(
                                  selectedHoldings: selectedHoldings,
                                  totalAmount: totalAmount,
                                  pledgeAmountList: state.pledgeAmountList,
                                ),
                              ),
                            );
                          },
                          text: "Pledge");
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
