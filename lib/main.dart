import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/domain/models/user_model.dart';
import 'package:liquipe/presentation/app/app_screen.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(MutualFundsHoldingsModelAdapter())
    ..registerAdapter(EquityTypeAdapter());
  await Hive.openBox<UserModel>('user');
  await Hive.openBox<double>('loanAmount');
  runApp(
    DevicePreview(
      builder: (context) => const LiquiPeApp(),
    ),
  );
}
