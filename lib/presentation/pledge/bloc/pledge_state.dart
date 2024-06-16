part of 'pledge_bloc.dart';

class PledgeState extends Equatable {
  final bool isLoading;
  final List<MutualFundsHoldingsModel> holdings;
  final bool isError;
  final List<MutualFundsHoldingsModel> selectedHoldings;
  final double percentagePledged;
  final List<double> pledgeAmountList;

  const PledgeState(
      {required this.isLoading,
      required this.holdings,
      required this.isError,
      required this.selectedHoldings,
      required this.percentagePledged,
      required this.pledgeAmountList});

  factory PledgeState.initial() {
    return const PledgeState(
      isLoading: true,
      holdings: [],
      isError: false,
      selectedHoldings: [],
      percentagePledged: 0,
      pledgeAmountList: [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        holdings,
        isError,
        selectedHoldings,
        percentagePledged,
        pledgeAmountList
      ];
}
