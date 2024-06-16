import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/domain/models/user_model.dart';
import 'package:liquipe/presentation/add_profile/bloc/add_profile_bloc.dart';
import 'package:liquipe/presentation/home/home_screen.dart';
import 'package:liquipe/presentation/utils/app_filled_button.dart';
import 'package:liquipe/presentation/utils/app_screen_template.dart';
import 'package:liquipe/presentation/utils/app_textfield.dart';
import 'package:liquipe/presentation/utils/fade_screen_transition.dart';
import 'package:liquipe/presentation/utils/poppins_text.dart';

class AddProfileScreen extends StatelessWidget {
  AddProfileScreen({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double widthRatio = MediaQuery.of(context).size.width / 430;
    double heightRatio = MediaQuery.of(context).size.height / 932;
    return AppScreenTemplate(
      isAuthScreen: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 33 * widthRatio, vertical: 70 * heightRatio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const PoppinsText(
              text: "Profile",
              fontSize: 36,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 55 * heightRatio,
            ),
            Column(
              children: <Widget>[
                AppTextfield(
                    labelText: "First Name",
                    textController: _firstNameController),
                AppTextfield(
                    labelText: "Last Name",
                    textController: _lastNameController),
                AppTextfield(
                    labelText: "Email Id", textController: _emailController),
                AppTextfield(
                    labelText: "Contact Number",
                    textController: _phoneController,
                    keyboardType: TextInputType.phone),
              ],
            ),
            SizedBox(
              height: 63 * heightRatio,
            ),
            BlocProvider(
              create: (context) => AddProfileBloc(),
              child: BlocConsumer<AddProfileBloc, AddProfileState>(
                listener: (context, state) {
                  if (state is ProfileSubmittedState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        fadeScreenTransition(const HomeScreen()),
                        (route) => false);
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
                        if (_firstNameController.text.isEmpty ||
                            _lastNameController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _phoneController.text.isEmpty) {
                          SnackBar snackBar = const SnackBar(
                            content: PoppinsText(
                              text: "Please fill all the fields",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,    
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        BlocProvider.of<AddProfileBloc>(context).add(
                          ProfileSubmitEvent(
                            userModel: UserModel(
                              name:
                                  "${_firstNameController.text} ${_lastNameController.text}",
                              email: _emailController.text,
                              contactNumber: int.parse(_phoneController.text),
                              userHoldings: const [
                                MutualFundsHoldingsModel(
                                    bankName: 'HDFC small cap fund',
                                    bankLogo: 'assets/images/hdfc.png',
                                    holdingAmount: 36312,
                                    equityType: EquityType.kfinTech),
                                MutualFundsHoldingsModel(
                                    bankName: 'ICICI Prudential small cap fund',
                                    bankLogo: 'assets/images/icici.png',
                                    holdingAmount: 45324,
                                    equityType: EquityType.kfinTech),
                              ],
                            ),
                          ),
                        );
                      },
                      text: "Continue");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
