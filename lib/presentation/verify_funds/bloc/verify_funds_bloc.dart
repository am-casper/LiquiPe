import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_funds_event.dart';
part 'verify_funds_state.dart';

class VerifyFundsBloc extends Bloc<VerifyFundsEvent, VerifyFundsState> {
  VerifyFundsBloc() : super(VerifyFundsInitial()) {
    on<VerifyFundsInitialEvent>((event, emit)async{
      emit(VerifyFundsLoading());
      await Future.delayed(const Duration(seconds: 2), () {
        emit(VerifyFundsLoaded());
      });
    });
  }
}
