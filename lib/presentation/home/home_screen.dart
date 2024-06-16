import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:liquipe/app_theme.dart';
import 'package:liquipe/domain/models/user_model.dart';
import 'package:liquipe/presentation/dashboard/dashboard_screen.dart';
import 'package:liquipe/presentation/get_started/get_started_screen.dart';
import 'package:liquipe/presentation/home/bloc/home_bloc.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String> getUser() async {
    Box<UserModel> userBox = await Hive.openBox<UserModel>('user');
    UserModel user = userBox.get('user')!;
    return user.name;
  }

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
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Hero(
                    tag: "navbar",
                    child: Container(
                      width: 175 * widthRatio,
                      height: 20 * heightRatio,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/home.svg',
                          height: 15 * heightRatio,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const PoppinsText(
                          text: "Home  ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            fadeScreenTransition(const DashboardScreen()));
                      },
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/dashboard.svg',
                            height: 15 * heightRatio,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const PoppinsText(
                            text: "Dashboard",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFFFBFCFF),
        body: SingleChildScrollView(
          child: Center(
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
                          SvgPicture.asset('assets/icons/avatar.svg',
                              height: 40),
                          const SizedBox(width: 10),
                          BlocProvider(
                            create: (context) => HomeBloc()..add(HomeEvent()),
                            child: BlocConsumer<HomeBloc, HomeState>(
                              listener: (context, state) {
                                if (state is NameError) {
                                  SnackBar snackBar = SnackBar(
                                    content: PoppinsText(
                                      text: state.error,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
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
                  const SizedBox(height: 40),
                  Column(
                    children: <Widget>[
                      const PoppinsText(
                          text: "Welcome!",
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: PoppinsText(
                          text:
                              "Click on Get Started to get money into your Account instantly!",
                          fontSize: 16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 45),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: AppFilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  fadeScreenTransition(
                                      const GetStartedScreen()));
                            },
                            text: "Get Started"),
                      )
                    ],
                  ),
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(-1, -1),
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFF5F5F5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0.1, 0.1),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/icons/magic.svg',
                                  height: 30),
                            ),
                            const SizedBox(height: 7),
                            const PoppinsText(
                              text: "Flat 10%",
                              fontSize: 10,
                            ),
                            const PoppinsText(
                              text: "interest rate",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFF5F5F5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0.1, 0.1),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/icons/clock.svg',
                                  height: 30),
                            ),
                            const SizedBox(height: 7),
                            const PoppinsText(
                              text: "Pay only",
                              fontSize: 10,
                            ),
                            const PoppinsText(
                              text: "interest monthly",
                              fontSize: 10,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFF5F5F5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0.1, 0.1),
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset('assets/icons/wallet.svg',
                                  height: 30),
                            ),
                            const SizedBox(height: 7),
                            const PoppinsText(
                              text: "zero",
                              fontSize: 10,
                            ),
                            const PoppinsText(
                              text: "hidden fees",
                              fontSize: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(-1, -1),
                          ),
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                          child: Column(
                            children: [
                              const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  children: <Widget>[
                                    PoppinsText(
                                      text: "Get ",
                                      fontSize: 16,
                                    ),
                                    PoppinsText(
                                      text: "Lower interest rates ",
                                      fontSize: 16,
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    PoppinsText(
                                      text: "with us!",
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  PoppinsText(
                                    text: "Loan against mutual funds",
                                    fontSize: 15 * widthRatio,
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // Expanded(child: SizedBox()),
                                  const PoppinsText(
                                      text: "10% p.a.",
                                      fontSize: 15,
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.bold)
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFDFDFDF),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PoppinsText(text: "Personal Loan"),
                              PoppinsText(text: "upto 30%")
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFFDFDFDF),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PoppinsText(text: "Credit Card loan"),
                              PoppinsText(text: "upto 40%")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
