import 'package:equatable/equatable.dart';

class KYCModel extends Equatable {
  final String panNo;
  final String aadharNo;

  const KYCModel({required this.panNo, required this.aadharNo});
  @override
  List<Object?> get props => [panNo, aadharNo];
}
