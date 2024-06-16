import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'statement_event.dart';
part 'statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {
  StatementBloc() : super(StatementLoading()) {
    on<StatementLoadEvent>((event, emit) async {
      try {
        Box<double> loanAmountBox = await Hive.openBox<double>('loanAmount');
        double loanAmount = loanAmountBox.get('loanAmount') ?? 0;
        emit(StatementLoaded(loanAmount: loanAmount));
      } catch (e) {
        emit(StatementError(message: e.toString()));
      }
    });
  }
}
