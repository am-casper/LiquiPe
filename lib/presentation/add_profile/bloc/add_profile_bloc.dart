import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:liquipe/domain/models/user_model.dart';

part 'add_profile_event.dart';
part 'add_profile_state.dart';

class AddProfileBloc extends Bloc<AddProfileEvent, AddProfileState> {
  AddProfileBloc() : super(const AddProfileState('')) {
    on<ProfileSubmitEvent>(_onProfileSubmitEvent);
  }

  FutureOr<void> _onProfileSubmitEvent(
      ProfileSubmitEvent event, Emitter<AddProfileState> emit) async {
    try {
      if (event.userModel.contactNumber.toString().length != 10) {
        emit(const AddProfileState("Invalid contact number"));
        emit(const AddProfileState(""));
        return;
      }
      Box<UserModel> userBox = await Hive.openBox<UserModel>('user');
      userBox.put('user', event.userModel);
      emit(const ProfileSubmittedState(""));
    } catch (e) {
      log(e.toString());
      emit(AddProfileState(e.toString()));
    }
  }
}
