part of 'fetch_portfolio_bloc.dart';

abstract class FetchPortfolioState extends Equatable {
  const FetchPortfolioState();
  
  @override
  List<Object> get props => [];
}

final class FetchPortfolioInitial extends FetchPortfolioState {}

final class FetchPortfolioLoading extends FetchPortfolioState {}

final class FetchPortfolioSuccess extends FetchPortfolioState {
  final List<bool> portfolioList;
  final EquityType equityTypeSelected;

  const FetchPortfolioSuccess({required this.portfolioList, required this.equityTypeSelected});

  @override
  List<Object> get props => [portfolioList, equityTypeSelected];
}

final class FetchPortfolioFailure extends FetchPortfolioState {
  final String error;

  const FetchPortfolioFailure(this.error);

  @override
  List<Object> get props => [error];
}