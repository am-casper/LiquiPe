import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquipe/domain/models/kyc_model.dart';
import 'package:liquipe/presentation/kyc/bloc/kyc_bloc.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/app_textfield.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';
import 'package:liquipe/presentation/utils/shadow_container.dart';
import 'package:liquipe/presentation/verify_kyc/verify_kyc_screen.dart';

class KYCScreen extends StatelessWidget {
  KYCScreen({super.key});

  final TextEditingController panController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
        isAuthScreen: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 50 * widthRatio, vertical: 40 * heightRatio),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: "KYC",
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
                child: const Material(
                    type: MaterialType.transparency,
                    child: PoppinsText(
                        text: "KYC",
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
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
                    const ShadowContainer(icon: "KYC", isBigIcon: true),
                    Positioned(
                      left: 200 * widthRatio,
                      top: 39 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Pledge", isBigIcon: false),
                    ),
                    Positioned(
                      left: 230 * widthRatio,
                      top: 54 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Sign eAgreement", isBigIcon: false),
                    ),
                    Positioned(
                      left: 257 * widthRatio,
                      top: 72 * heightRatio,
                      child: const ShadowContainer(
                          icon: "Setup Auto-debit", isBigIcon: false),
                    ),
                    Positioned(
                      right: 200 * widthRatio,
                      top: 39 * heightRatio,
                      child: const ShadowContainer(
                          icon: "portfolio", isBigIcon: false),
                    ),
                    Positioned(
                        top: 82 * heightRatio,
                        child: const PoppinsText(text: "2/5"))
                  ],
                ),
              ),
              SizedBox(
                height: 70 * heightRatio,
              ),
              AppTextfield(
                  labelText: "PAN Card Number", textController: panController),
              SizedBox(height: 30 * heightRatio),
              AppTextfield(
                  labelText: "Aadhar Number", textController: aadharController, keyboardType: TextInputType.number,),
              SizedBox(height: 12 * heightRatio),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25 * widthRatio),
                child: const PoppinsText(
                  // text:
                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at lacus rhoncus, dictum nibh convalli",
                  text: "",
                  fontSize: 10,
                ),
              ),
              SizedBox(height: 70 * heightRatio),
              BlocProvider(
                create: (context) => KYCBloc(),
                child: BlocConsumer<KYCBloc, KYCState>(
                  listener: (context, state) {
                    if (state.isSuccess) {
                      Navigator.push(
                          context, fadeScreenTransition(VerifyKycScreen()));
                    }
                    if (state.error.isNotEmpty) {
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
                  builder: (context, state) {
                    return AppFilledButton(
                        onPressed: () {
                          context.read<KYCBloc>().add(KycSubmitEvent(
                              kycModel: KYCModel(
                                  panNo: panController.text,
                                  aadharNo: aadharController.text)));
                        },
                        text: "Continue");
                  },
                ),
              )
            ],
          ),
        ));
  }
}
