import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:liquipe/domain/models/mutual_funds_holdings_model.dart';
import 'package:liquipe/domain/models/user_model.dart';

part 'fetch_portfolio_event.dart';
part 'fetch_portfolio_state.dart';

class FetchPortfolioBloc
    extends Bloc<FetchPortfolioEvent, FetchPortfolioState> {
  FetchPortfolioBloc() : super(FetchPortfolioInitial()) {
    on<FetchPortfolioInitiate>(_onFetchPortfolioInitiate);
    on<EquityTypeSelected>(_onEquityTypeSelected);
  }

  FutureOr<void> _onFetchPortfolioInitiate(
      FetchPortfolioInitiate event, Emitter<FetchPortfolioState> emit) async {
    try {
      emit(FetchPortfolioLoading());
      Box<UserModel> userBox = await Hive.openBox<UserModel>('user');
      List<MutualFundsHoldingsModel> holdings =
          userBox.get('user')!.userHoldings;
      List<bool> portfolioList = [false, false];
      for (var holding in holdings) {
        if (holding.equityType == EquityType.kfinTech) {
          portfolioList[0] = true;
        } else if (holding.equityType == EquityType.cams) {
          portfolioList[1] = true;
        }
      }
      emit(FetchPortfolioSuccess(
          portfolioList: portfolioList,
          equityTypeSelected: EquityType.initiate));
    } catch (e) {
      emit(FetchPortfolioFailure(e.toString()));
    }
  }

  FutureOr<void> _onEquityTypeSelected(
      EquityTypeSelected event, Emitter<FetchPortfolioState> emit) {
    if (state is FetchPortfolioSuccess) {
      emit(FetchPortfolioSuccess(
          portfolioList: event.portfolioList,
          equityTypeSelected: event.equityTypeSelected));
    } else {}
  }
}
