import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/presentation/fetch_portfolio/bloc/fetch_portfolio_bloc.dart';
import 'package:liquipe/presentation/kyc/kyc_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/utils/shadow_container.dart';

class FetchPortfolioScreen extends StatelessWidget {
  const FetchPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return BlocProvider(
      create: (context) =>
          FetchPortfolioBloc()..add(const FetchPortfolioInitiate()),
      child: AppScreenTemplate(
        isAuthScreen: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40 * widthRatio),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 40 * heightRatio, bottom: 24 * heightRatio),
                child: Hero(
                  tag: "fetchPortfolio",
                  // createRectTween: (begin, end) {
                  //   return QuadraticRectTween(begin: begin, end: end);
                  // },
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    return DefaultTextStyle(
                      style: DefaultTextStyle.of(toHeroContext).style,
                      child: toHeroContext.widget,
                    );
                  },
                  //     (flightContext, animation, direction, fromContext, toContext) {
                  //   return SingleChildScrollView(child: fromContext.widget);
                  // },
                  // child: const Material(
                  //   type: MaterialType.transparency,
                  //   child: Row(
                  //     children: [
                  //       PoppinsText(
                  //         text: "Fetch ",
                  //         fontSize: 36,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //       PoppinsText(
                  //         text: "Portfolio",
                  //         fontSize: 36,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  child: const Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              PoppinsText(
                                text: "Fetch ",
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              PoppinsText(
                                text: "Portfolio",
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Stack(alignment: Alignment.topCenter, children: [
                  SizedBox(
                    width: double.infinity,
                    height: 114 * heightRatio,
                  ),
                  const ShadowContainer(icon: "portfolio", isBigIcon: true),
                  Positioned(
                    left: 223 * widthRatio,
                    top: 34 * heightRatio,
                    child: _animatedIcon("KYC"),
                  ),
                  Positioned(
                    left: 255 * widthRatio,
                    top: 43 * heightRatio,
                    child: _animatedIcon("Pledge"),
                  ),
                  Positioned(
                    left: 287 * widthRatio,
                    top: 58 * heightRatio,
                    child: _animatedIcon("Sign eAgreement"),
                  ),
                  Positioned(
                    left: 317 * widthRatio,
                    top: 76 * heightRatio,
                    child: _animatedIcon("Setup Auto-debit"),
                  ),
                  Positioned(
                      top: 82 * heightRatio,
                      child: const PoppinsText(text: "1/5"))
                ]),
              ),
              SizedBox(
                height: 50 * heightRatio,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PoppinsText(
                    text: "Your Mutual funds portfolio",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 20 * heightRatio,
                  ),
                  BlocBuilder<FetchPortfolioBloc, FetchPortfolioState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (state is FetchPortfolioSuccess &&
                                  state.portfolioList[0]) {
                                if (state.equityTypeSelected ==
                                    EquityType.kfinTech) {
                                  context.read<FetchPortfolioBloc>().add(
                                      EquityTypeSelected(
                                          portfolioList: state.portfolioList,
                                          equityTypeSelected:
                                              EquityType.initiate));
                                  return;
                                }
                                context.read<FetchPortfolioBloc>().add(
                                    EquityTypeSelected(
                                        portfolioList: state.portfolioList,
                                        equityTypeSelected:
                                            EquityType.kfinTech));
                              }
                            },
                            child: Container(
                              width: 169 * widthRatio,
                              padding:
                                  const EdgeInsets.fromLTRB(17, 17, 17, 27),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                border: Border.all(
                                  color: Colors.black.withOpacity(
                                      state is FetchPortfolioSuccess &&
                                              state.portfolioList[0] &&
                                              state.equityTypeSelected ==
                                                  EquityType.kfinTech
                                          ? 1
                                          : 0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/kfintech.png",
                                    width: 127 * widthRatio,
                                  ),
                                  SizedBox(
                                    height: 34 * heightRatio,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17),
                                    child: PoppinsText(
                                      text: state is FetchPortfolioSuccess
                                          ? state.portfolioList[0]
                                              ? "Portfolio found"
                                              : "Portfolio not found"
                                          : "Error in fetching Portfolio",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (state is FetchPortfolioSuccess &&
                                  state.portfolioList[1]) {
                                if (state.equityTypeSelected ==
                                    EquityType.cams) {
                                  context.read<FetchPortfolioBloc>().add(
                                      EquityTypeSelected(
                                          portfolioList: state.portfolioList,
                                          equityTypeSelected:
                                              EquityType.initiate));
                                  return;
                                }
                                context.read<FetchPortfolioBloc>().add(
                                    EquityTypeSelected(
                                        portfolioList: state.portfolioList,
                                        equityTypeSelected: EquityType.cams));
                              }
                            },
                            child: Container(
                              width: 169 * widthRatio,
                              padding:
                                  const EdgeInsets.fromLTRB(17, 14, 17, 27),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                border: Border.all(
                                  color: Colors.black.withOpacity(
                                      state is FetchPortfolioSuccess &&
                                              state.portfolioList[1] &&
                                              state.equityTypeSelected ==
                                                  EquityType.cams
                                          ? 1
                                          : 0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/cams.png",
                                    width: 89 * widthRatio,
                                  ),
                                  SizedBox(
                                    height: 31 * heightRatio,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17),
                                    child: PoppinsText(
                                      text: state is FetchPortfolioSuccess
                                          ? state.portfolioList[1]
                                              ? "Portfolio found"
                                              : "Portfolio not found"
                                          : "Error in fetching Portfolio",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50 * heightRatio,
              ),
              const PoppinsText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at lacus rhoncus, dictum nibh convallis, porta neque. Suspendisse ullamcorper consequat pretium. Duis ac lacus placerat, cursus neque ut, facilisis est. Sed congue dui sed risus facilisis, quis malesuada sapien finibus. Vestibulum sed magna pellentesque, blandit ipsum non, cursus lorem.",
                fontSize: 10,
                color: Color(0xFF606060),
              ),
              SizedBox(
                height: 50 * heightRatio,
              ),
              BlocBuilder<FetchPortfolioBloc, FetchPortfolioState>(
                builder: (context, state) {
                  return AppFilledButton(
                      onPressed: state is FetchPortfolioSuccess &&
                              state.equityTypeSelected == EquityType.initiate
                          ? () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: PoppinsText(
                                  text: "Please select a portfolio",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ));
                            }
                          : () {
                              Navigator.push(
                                  context, fadeScreenTransition(KYCScreen()));
                            },
                      text: "Continue");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _animatedIcon(String icon) {
  return Hero(
    tag: icon,
    flightShuttleBuilder: (
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
    ) {
      return DefaultTextStyle(
        style: DefaultTextStyle.of(toHeroContext).style,
        child: Wrap(children: [toHeroContext.widget]),
      );
    },
    placeholderBuilder: (context, heroSize, child) => child,
    child: ShadowContainer(
      icon: icon,
      isBigIcon: false,
    ),
  );
}
// class QuadraticRectTween extends RectTween {
//   QuadraticRectTween({
//     super.begin,
//     super.end,
//   });

//   bool _dirty = true;

//   void _initialize() {
//     assert(begin != null);
//     assert(end != null);
//     _centerArc = QuadraticOffsetTween(
//       begin: begin!.center,
//       end: end!.center,
//     );
//     _dirty = false;
//   }

//   QuadraticOffsetTween? get centerArc {
//     if (begin == null || end == null) {
//       return null;
//     }
//     if (_dirty) {
//       _initialize();
//     }
//     return _centerArc;
//   }

//   late QuadraticOffsetTween _centerArc;

//   @override
//   set begin(Rect? value) {
//     if (value != begin) {
//       super.begin = value;
//       _dirty = true;
//     }
//   }

//   @override
//   set end(Rect? value) {
//     if (value != end) {
//       super.end = value;
//       _dirty = true;
//     }
//   }

//   @override
//   Rect lerp(double t) {
//     if (_dirty) {
//       _initialize();
//     }
//     if (t == 0.0) {
//       return begin!;
//     }
//     if (t == 1.0) {
//       return end!;
//     }
//     final Offset center = _centerArc.lerp(t);
//     final double width = lerpDouble(begin!.width, end!.width, t)!;
//     final double height = lerpDouble(begin!.height, end!.height, t)!;
//     return Rect.fromLTWH(
//         center.dx - width / 2.0, center.dy - height / 2.0, width, height);
//   }
// }

// class QuadraticOffsetTween extends Tween<Offset> {
//   QuadraticOffsetTween({
//     required Offset begin,
//     required Offset end,
//   }) : super(begin: begin, end: end);

//   @override
//   Offset lerp(double t) {
//     if (t == 0.0) {
//       return begin!;
//     }
//     if (t == 1.0) {
//       return end!;
//     }
//     final double x =
//         ( begin!.dx * math.pow(t, 2) + (end!.dx + -2 * begin!.dx) * t) +
//             begin!.dx;
//     final double y =
//         (begin!.dy * math.pow(t, 2) + (end!.dy + -2 * begin!.dy) * t) +
//             begin!.dy;
//     return Offset(end!.dx, y);
//   }
// }
