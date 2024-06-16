import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';

part 'pledge_event.dart';
part 'pledge_state.dart';

class PledgeBloc extends Bloc<PledgeEvent, PledgeState> {
  PledgeBloc() : super(PledgeState.initial()) {
    on<PledgeInitialEvent>(_onPledgeInitialEvent);
    on<PledgeSelectHoldingsEvent>(_onPledgeSelectHoldingsEvent);
    on<PledgePercentageChangeEvent>(_onPledgePercentageChangeEvent);
    on<PledgeAmountChangeEvent>(_onPledgeAmountChangeEvent);
  }

  FutureOr<void> _onPledgeInitialEvent(
      PledgeInitialEvent event, Emitter<PledgeState> emit) {
    List<MutualFundsHoldingsModel> holdings = [
      const MutualFundsHoldingsModel(
          bankName: 'HDFC small cap fund',
          bankLogo: 'assets/images/hdfc.png',
          holdingAmount: 36312,
          equityType: EquityType.kfinTech),
      const MutualFundsHoldingsModel(
          bankName: 'ICICI Prudential small cap fund',
          bankLogo: 'assets/images/icici.png',
          holdingAmount: 45324,
          equityType: EquityType.kfinTech),
    ];
    emit(PledgeState(
      isLoading: false,
      holdings: holdings,
      isError: false,
      selectedHoldings: const [],
      percentagePledged: 50,
      pledgeAmountList: List<double>.filled(holdings.length, 0),
    ));
  }

  FutureOr<void> _onPledgeSelectHoldingsEvent(
      PledgeSelectHoldingsEvent event, Emitter<PledgeState> emit) {
    if (state.selectedHoldings.contains(event.holding)) {
      List<double> indexList = state.pledgeAmountList;
      indexList[event.index] = 0;
      state.selectedHoldings.remove(event.holding);
      emit(PledgeState(
          isLoading: true,
          holdings: state.holdings,
          isError: state.isError,
          selectedHoldings: state.selectedHoldings,
          percentagePledged: state.percentagePledged,
          pledgeAmountList: indexList));
      emit(PledgeState(
          isLoading: false,
          holdings: state.holdings,
          isError: state.isError,
          selectedHoldings: state.selectedHoldings,
          percentagePledged: state.percentagePledged,
          pledgeAmountList: indexList));
    } else {
      emit(PledgeState(
          isLoading: false,
          holdings: state.holdings,
          isError: state.isError,
          selectedHoldings: [...state.selectedHoldings, event.holding],
          percentagePledged: state.percentagePledged,
          pledgeAmountList: state.pledgeAmountList));
    }
  }

  FutureOr<void> _onPledgePercentageChangeEvent(
      PledgePercentageChangeEvent event, Emitter<PledgeState> emit) {
    emit(PledgeState(
        isLoading: false,
        holdings: state.holdings,
        isError: state.isError,
        selectedHoldings: state.selectedHoldings,
        percentagePledged: event.percentage,
        pledgeAmountList: state.pledgeAmountList));
    emit(PledgeState(
        isLoading: true,
        holdings: state.holdings,
        isError: state.isError,
        selectedHoldings: state.selectedHoldings,
        percentagePledged: event.percentage,
        pledgeAmountList: state.pledgeAmountList));
  }

  FutureOr<void> _onPledgeAmountChangeEvent(
      PledgeAmountChangeEvent event, Emitter<PledgeState> emit) {
    List<double> pledgeAmountList = state.pledgeAmountList;
    pledgeAmountList[event.index] = event.amount;
    emit(PledgeState(
        isLoading: false,
        holdings: state.holdings,
        isError: state.isError,
        selectedHoldings: state.selectedHoldings,
        percentagePledged: state.percentagePledged,
        pledgeAmountList: pledgeAmountList));
  }
}
