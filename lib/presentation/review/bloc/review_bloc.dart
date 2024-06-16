import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<ReviewSubmitEvent>((event, emit) async {
      try {
        Box<double> loanAmountBox = await Hive.openBox<double>('loanAmount');
        loanAmountBox.put('loanAmount', event.loanAmount);
        emit(ReviewSuccess());
      } catch (e) {
        emit(ReviewFailure(e.toString()));
        emit(ReviewInitial());
      }
    });
  }
}
