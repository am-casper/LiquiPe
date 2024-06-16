part of 'verify_funds_bloc.dart';

abstract class VerifyFundsState extends Equatable {
  const VerifyFundsState();
  
  @override
  List<Object> get props => [];
}

final class VerifyFundsInitial extends VerifyFundsState {}

final class VerifyFundsLoading extends VerifyFundsState {}

final class VerifyFundsLoaded extends VerifyFundsState {}