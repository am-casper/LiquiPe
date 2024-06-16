import 'package:equatable/equatable.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final int contactNumber;
  @HiveField(3)
  final List<MutualFundsHoldingsModel> userHoldings;

  const UserModel(
      {required this.name,
      required this.email,
      required this.contactNumber,
      required this.userHoldings});

  @override
  List<Object?> get props => [name, email, contactNumber, userHoldings];
}
