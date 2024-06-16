part of 'statement_bloc.dart';

abstract class StatementEvent extends Equatable {
  const StatementEvent();

  @override
  List<Object> get props => [];
}

class StatementLoadEvent extends StatementEvent {
  const StatementLoadEvent();

  @override
  List<Object> get props => [];
}