import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:liquipe/presentation/home/bloc/home_bloc.dart';
import 'package:liquipe/presentation/home/home_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 40 * widthRatio, vertical: 20 * heightRatio),
            padding: EdgeInsets.symmetric(
                vertical: 5 * heightRatio, horizontal: 5 * heightRatio),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Hero(
                    tag: "navbar",
                    child: Container(
                      width: 190 * widthRatio,
                      height: 20 * heightRatio,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context, fadeScreenTransition(const HomeScreen()));
                      },
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/home.svg',
                            height: 15 * heightRatio,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const PoppinsText(
                            text: "Home  ",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/dashboard.svg',
                          height: 15 * heightRatio,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const PoppinsText(
                          text: "Dashboard",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFFFBFCFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(35 * widthRatio, 55 * heightRatio,
                35 * widthRatio, 100 * heightRatio),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/icons/avatar.svg', height: 40),
                        const SizedBox(width: 10),
                        BlocProvider(
                          create: (context) => HomeBloc()..add(HomeEvent()),
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state is HomeLoading) {
                                return const CircularProgressIndicator();
                              } else if (state is NameLoaded) {
                                return PoppinsText(
                                    text: "Hello, ${state.name}!",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFF5F5F5),
                        ),
                        child: SvgPicture.asset('assets/icons/notif.svg',
                            height: 30),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 35 * heightRatio),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * widthRatio, vertical: 30 * heightRatio),
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
                    border:
                        Border.all(color: const Color(0xFFE9E9E9), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const PoppinsText(
                        text: "Available Cash",
                        fontSize: 10,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          PoppinsText(
                            text: "INR ",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          PoppinsText(
                            text: "1,48,000",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: 25 * heightRatio),
                      Stack(
                        children: [
                          Container(
                            height: 8 * heightRatio,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Container(
                            height: 8 * heightRatio,
                            width: 52 * widthRatio,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15 * heightRatio),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          PoppinsText(
                            text: "INR 12K",
                            fontSize: 12,
                          ),
                          PoppinsText(
                            text: "of INR 1XXX",
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25 * heightRatio),
                AppFilledButton(
                  onPressed: () {},
                  text: "Withdraw",
                  color: Colors.black,
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
                    border:
                        Border.all(color: const Color(0xFFE9E9E9), width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20 * widthRatio,
                            17 * heightRatio, 20 * widthRatio, 0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PoppinsText(
                              text: "Interest Status",
                              fontWeight: FontWeight.w500,
                            ),
                            PoppinsText(
                              text: "On Track",
                              fontSize: 12,
                            ),
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
                            10 * heightRatio,
                            20 * widthRatio,
                            28 * heightRatio),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                SvgPicture.asset("assets/icons/attention.svg"),
                                SizedBox(width: 7 * widthRatio),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const PoppinsText(
                                      text: "Upcoming interest autopay",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 2 * heightRatio),
                                    const PoppinsText(
                                      text: "7th June 2024",
                                      fontSize: 8,
                                      color: Color(0xFF7D7D7D),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            BlocProvider(
                              create: (context) =>
                                  DashboardBloc()..add(DashboardLoadEvent()),
                              child:
                                  BlocConsumer<DashboardBloc, DashboardState>(
                                      listener: (context, state) {
                              }, builder: (context, state) {
                                if (state is DashboardLoaded) {
                                  return PoppinsText(
                                    text: "INR ${state.loanAmount * 0.105}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.primaryColor,
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40 * heightRatio),
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
                    border:
                        Border.all(color: const Color(0xFFE9E9E9), width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20 * widthRatio,
                            20 * heightRatio, 20 * widthRatio, 7 * heightRatio),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const PoppinsText(
                              text: "Account Activity",
                              fontSize: 16,
                            ),
                            Transform.rotate(
                                angle: math.pi / 2,
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
                          vertical: 7 * heightRatio,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PoppinsText(
                                  text: "Interest Paid",
                                  fontSize: 12,
                                ),
                                PoppinsText(
                                    text: "7th May 2024",
                                    fontSize: 8,
                                    color: Color(0xFF7D7D7D))
                              ],
                            ),
                            PoppinsText(
                              text: "INR 650",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PoppinsText(
                                  text: "Withdrawn to 12XX",
                                  fontSize: 12,
                                ),
                                PoppinsText(
                                    text: "7th May 2024",
                                    fontSize: 8,
                                    color: Color(0xFF7D7D7D))
                              ],
                            ),
                            PoppinsText(
                              text: "INR 6500",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PoppinsText(
                                  text: "Interest Paid",
                                  fontSize: 12,
                                ),
                                PoppinsText(
                                    text: "7th May 2024",
                                    fontSize: 8,
                                    color: Color(0xFF7D7D7D))
                              ],
                            ),
                            PoppinsText(
                              text: "INR 650",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
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
