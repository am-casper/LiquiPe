part of 'verify_funds_bloc.dart';

abstract class VerifyFundsEvent extends Equatable {
  const VerifyFundsEvent();

  @override
  List<Object> get props => [];
}

final class VerifyFundsInitialEvent extends VerifyFundsEvent {}

final class VerifyFundsSubmitEvent extends VerifyFundsEvent {}