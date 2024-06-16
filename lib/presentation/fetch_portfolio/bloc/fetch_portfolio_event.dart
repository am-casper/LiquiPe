part of 'fetch_portfolio_bloc.dart';

abstract class FetchPortfolioEvent extends Equatable {
  const FetchPortfolioEvent();

  @override
  List<Object> get props => [];
}

class FetchPortfolioInitiate extends FetchPortfolioEvent {
  const FetchPortfolioInitiate();

  @override
  List<Object> get props => [];
}

class EquityTypeSelected extends FetchPortfolioEvent {
  final EquityType equityTypeSelected;
  final List<bool> portfolioList;

  const EquityTypeSelected({required this.equityTypeSelected, required this.portfolioList});

  @override
  List<Object> get props => [equityTypeSelected, portfolioList];
}
