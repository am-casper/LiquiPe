part of 'statement_bloc.dart';

abstract class StatementState extends Equatable {
  const StatementState();
  
  @override
  List<Object> get props => [];
}

final class StatementLoading extends StatementState {}

final class StatementLoaded extends StatementState {
  final double loanAmount;

  const StatementLoaded({required this.loanAmount});

  @override
  List<Object> get props => [loanAmount];
}

final class StatementError extends StatementState {
  final String message;

  const StatementError({required this.message});

  @override
  List<Object> get props => [message];
}