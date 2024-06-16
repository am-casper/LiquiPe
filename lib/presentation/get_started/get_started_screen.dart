import 'package:flutter/material.dart';
// import 'package:hero_text/hero_text.dart';
import 'package:liquipe/presentation/fetch_portfolio/fetch_portfolio_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthRatio = width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
      isAuthScreen: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30 * widthRatio, vertical: 40 * heightRatio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const PoppinsText(
              text: "Loan against Mutual Funds",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 40 * heightRatio,
            ),
            const PoppinsText(
              text: "Access instant credit in just 5 simple steps!",
              fontSize: 16,
            ),
            SizedBox(
              height: 60 * heightRatio,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/details.png",
                    height: 420 * heightRatio,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 19 * heightRatio,
                    left: 220 * widthRatio,
                    child: const Hero(
                      tag: "fetchPortfolio",
                      child: PoppinsText(
                        text: "Fetch Portfolio",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110 * heightRatio,
                    right: 225 * widthRatio,
                    child: _animatedIcon("KYC"),
                  ),
                  Positioned(
                    top: 198 * heightRatio,
                    left: 220 * widthRatio,
                    child: _animatedIcon("Pledge"),
                  ),
                  Positioned(
                    top: 289 * heightRatio,
                    right: 225 * widthRatio,
                    child: _animatedIcon("Sign eAgreement"),
                  ),
                  Positioned(
                    top: 379 * heightRatio,
                    left: 220 * widthRatio,
                    child: _animatedIcon("Setup Auto-debit"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70 * heightRatio,
            ),
            AppFilledButton(
                onPressed: () {
                  Navigator.push(context,
                      fadeScreenTransition(const FetchPortfolioScreen()));
                },
                text: "Fetch Portfolio")
          ],
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
        style: DefaultTextStyle.of(fromHeroContext).style,
        child: Wrap(children: [fromHeroContext.widget]),
      );
    },
    child: PoppinsText(
      text: icon,
      fontWeight: FontWeight.w500,
    ),
  );
}
