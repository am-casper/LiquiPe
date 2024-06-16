import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardLoadEvent>((event, emit) async {
      try {
        Box<double> loanAmountBox = await Hive.openBox<double>('loanAmount');
        double loanAmount = loanAmountBox.get('loanAmount') ?? 0;
        emit(DashboardLoaded(loanAmount));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}
