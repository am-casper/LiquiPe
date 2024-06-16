part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();
  
  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

final class ReviewSuccess extends ReviewState {}

final class ReviewFailure extends ReviewState {
  final String error;

  const ReviewFailure(this.error);

  @override
  List<Object> get props => [error];
}
