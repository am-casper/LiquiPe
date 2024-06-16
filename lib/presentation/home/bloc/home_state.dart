part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class NameLoaded extends HomeState {
  final String name;
  const NameLoaded(this.name);

  @override
  List<Object> get props => [name];
}

final class NameError extends HomeState {
  final String error;
  const NameError(this.error);

  @override
  List<Object> get props => [error];
}
