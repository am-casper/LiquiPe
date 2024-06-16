part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

final class ReviewSubmitEvent extends ReviewEvent {
  final double loanAmount;

  const ReviewSubmitEvent({required this.loanAmount});

  @override
  List<Object> get props => [loanAmount];
}
