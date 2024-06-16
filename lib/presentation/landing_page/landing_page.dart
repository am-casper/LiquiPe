import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:liquipe/app_theme.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:liquipe/presentation/login/login_screen.dart';
import 'package:liquipe/presentation/signup/signup_screen.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double heightRatio = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ConstrainedBox(
            //   constraints: const BoxConstraints(
            //     maxHeight: 100,
            //   ),
            //   child: SizedBox(
            //     height: 100 * heightRatio,
            //   ),
            // ),
            const SizedBox(
              height: 0,
            ),
            SvgPicture.asset('assets/images/hero.svg'),
            // ConstrainedBox(
            //     constraints: const BoxConstraints(maxHeight: 60),
            //     child: SizedBox(height: 60 * heightRatio)),
            Container(
              width: double.infinity,
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
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      PoppinsText(
                          text: "Welcome to",
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      SizedBox(
                        height: 2,
                      ),
                      PoppinsText(
                          text: "LiquiPe",
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46),
                        child: PoppinsText(
                            text:
                                "One Stop for Loan against All Securities. Pledge your securities and get instant loan.",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF606060),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                fadeScreenTransition(const LoginScreen()),
                              );
                            },
                            child: Hero(
                              tag: "login",
                              flightShuttleBuilder: (
                                BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext,
                              ) {
                                return DefaultTextStyle(
                                  style: DefaultTextStyle.of(fromHeroContext)
                                      .style,
                                  child:
                                      Wrap(children: [fromHeroContext.widget]),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 44, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.primaryColor, width: 2),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: PoppinsText(
                                      text: "Login",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                fadeScreenTransition(SignupScreen()),
                              );
                            },
                            child: Hero(
                              tag: "signUp",
                              flightShuttleBuilder: (
                                BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext,
                              ) {
                                return DefaultTextStyle(
                                  style: DefaultTextStyle.of(fromHeroContext)
                                      .style,
                                  child:
                                      Wrap(children: [fromHeroContext.widget]),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 36, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.primaryColor, width: 2),
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: PoppinsText(
                                      text: "Sign Up",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              // flightShuttleBuilder: (flightContext, animation,
                              //     direction, fromContext, toContext) {
                              //   return AnimatedBuilder(
                              //     animation: animation,
                              //     builder: (context, child) {
                              //       double value = Curves.elasticOut
                              //           .transform(animation.value);
                              //       return Transform.scale(
                              //         scale: 1 + value * 0.3,
                              //         child: child,
                              //       );
                              //     },
                              //     child: toContext.widget,
                              //   );
                              // },
                              // createRectTween: (begin, end) {
                              //   return QuadraticRectTween(
                              //       begin: begin, end: end);
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuadraticRectTween extends RectTween {
  QuadraticRectTween({
    super.begin,
    super.end,
  });

  bool _dirty = true;

  void _initialize() {
    assert(begin != null);
    assert(end != null);
    _centerArc = QuadraticOffsetTween(
      begin: begin!.center,
      end: end!.center,
    );
    _dirty = false;
  }

  /// If [begin] and [end] are non-null, returns a tween that interpolates along
  /// a circular arc between [begin]'s [Rect.center] and [end]'s [Rect.center].
  QuadraticOffsetTween? get centerArc {
    if (begin == null || end == null) {
      return null;
    }
    if (_dirty) {
      _initialize();
    }
    return _centerArc;
  }

  late QuadraticOffsetTween _centerArc;

  @override
  set begin(Rect? value) {
    if (value != begin) {
      super.begin = value;
      _dirty = true;
    }
  }

  @override
  set end(Rect? value) {
    if (value != end) {
      super.end = value;
      _dirty = true;
    }
  }

  @override
  Rect lerp(double t) {
    if (_dirty) {
      _initialize();
    }
    if (t == 0.0) {
      return begin!;
    }
    if (t == 1.0) {
      return end!;
    }
    final Offset center = _centerArc.lerp(t);
    final double width = lerpDouble(begin!.width, end!.width, t)!;
    final double height = lerpDouble(begin!.height, end!.height, t)!;
    return Rect.fromLTWH(
        center.dx - width / 2.0, center.dy - height / 2.0, width, height);
  }
}

class QuadraticOffsetTween extends Tween<Offset> {
  QuadraticOffsetTween({
    required Offset begin,
    required Offset end,
  }) : super(begin: begin, end: end);

  @override
  Offset lerp(double t) {
    if (t == 0.0) {
      return begin!;
    }
    if (t == 1.0) {
      return end!;
    }
    final double x =
        (begin!.dx * math.pow(t, 2) + (end!.dx + -2 * begin!.dx) * t) +
            begin!.dx;
    final double y =
        (begin!.dy * math.pow(t, 2) + (end!.dy + -2 * begin!.dy) * t) +
            begin!.dy;
    return Offset(x, y);
  }
}
