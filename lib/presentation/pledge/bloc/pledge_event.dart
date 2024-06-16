part of 'pledge_bloc.dart';

abstract class PledgeEvent {}

class PledgeInitialEvent extends PledgeEvent {}

class PledgeSelectHoldingsEvent extends PledgeEvent {
  final MutualFundsHoldingsModel holding;
  final int index;

  PledgeSelectHoldingsEvent({required this.holding, required this.index});
}

class PledgePercentageChangeEvent extends PledgeEvent {
  final double percentage;

  PledgePercentageChangeEvent({required this.percentage});
}

class PledgeAmountChangeEvent extends PledgeEvent {
  final double amount;
  final int index;

  PledgeAmountChangeEvent({required this.amount, required this.index});
}
