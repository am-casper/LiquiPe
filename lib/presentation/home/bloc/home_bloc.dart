import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:liquipe/domain/models/user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>(_initialize);
  }

  Future<FutureOr<void>> _initialize(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      Box<UserModel> userBox = await Hive.openBox<UserModel>('user');
      emit(NameLoaded(userBox.get('user')!.name));
    } catch (e) {
      emit(NameError(e.toString()));
    }
  }
}
