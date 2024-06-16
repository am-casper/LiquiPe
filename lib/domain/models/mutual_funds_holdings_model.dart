import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'mutual_funds_holdings_model.g.dart';

@HiveType(typeId: 2)
enum EquityType {
  @HiveField(0)
  kfinTech,
  @HiveField(1)
  cams,
  @HiveField(2)
  initiate
}

@HiveType(typeId: 1)
class MutualFundsHoldingsModel extends Equatable {
  @HiveField(0)
  final String bankName;
  @HiveField(1)
  final String bankLogo;
  @HiveField(2)
  final double holdingAmount;
  @HiveField(3)
  final EquityType equityType;

  const MutualFundsHoldingsModel(
      {required this.bankName,
      required this.bankLogo,
      required this.holdingAmount,
      required this.equityType});
  @override
  List<Object?> get props => [bankName, bankLogo, holdingAmount, equityType];
}
