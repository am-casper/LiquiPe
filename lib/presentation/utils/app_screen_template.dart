import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquipe/app_theme.dart';

class AppScreenTemplate extends StatelessWidget {
  final Widget child;
  final bool isAuthScreen;

  const AppScreenTemplate(
      {super.key, required this.isAuthScreen, required this.child});

  @override
  Widget build(BuildContext context) {
    double heightRatio = (MediaQuery.of(context).size.height) / 932;
    double widthRatio = MediaQuery.of(context).size.width / 430;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 40,
                        ),
                        child: Container(
                          height: 40 * heightRatio,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30 * widthRatio),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/back-arrow.svg'),
                            ),
                            if (!isAuthScreen)
                              SvgPicture.asset("assets/icons/notif.svg")
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 70 / (isAuthScreen ? 1 : 2),
                        ),
                        child: Container(
                          height: 70 * heightRatio / (isAuthScreen ? 1 : 2),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: (isAuthScreen ? 780 : 830) * heightRatio,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, -0.5),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: child),
                    ]),
              )
            ],
          )),
    );
  }
}
