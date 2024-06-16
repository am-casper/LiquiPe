import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer(
      {super.key, required this.icon, required this.isBigIcon});

  final String icon;
  final bool isBigIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isBigIcon ? 14 : 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B39F4).withOpacity(0.5),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: -0.0,
            blurRadius: 30.0,
          ),
        ],
      ),
      child: SvgPicture.asset(
        "assets/icons/$icon.svg",
        height:
            (isBigIcon ? 40 : 15) * MediaQuery.of(context).size.height / 932,
      ),
    );
  }
}
