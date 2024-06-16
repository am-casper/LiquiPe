import 'package:flutter/material.dart';
import 'package:liquipe/presentation/landing_page/landing_page.dart';

class LiquiPeApp extends StatefulWidget {
  const LiquiPeApp({super.key});

  @override
  State<LiquiPeApp> createState() => _LiquiPeAppState();
}

class _LiquiPeAppState extends State<LiquiPeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LiquiPe',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SafeArea(child: LandingPage()),
    );
  }
}
