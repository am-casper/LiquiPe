import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:liquipe/domain/models/kyc_model.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KYCBloc extends Bloc<KYCEvent, KYCState> {
  KYCBloc() : super(KYCState.initial()) {
    on<KycSubmitEvent>(_onKYCSubmitEvent);
  }

  FutureOr<void> _onKYCSubmitEvent(
      KycSubmitEvent event, Emitter<KYCState> emit) {
    KYCModel kycModel = event.kycModel;
    if (kycModel.panNo.length != 10) {
      emit(const KYCState(
          error: 'PAN Card Number Length should be 10', isSuccess: false));
      emit(const KYCState(error: '', isSuccess: false));
      return null;
    }
    if (kycModel.aadharNo.length != 12) {
      emit(const KYCState(
          error: 'Aadhar Number Length should be 12', isSuccess: false));
      emit(const KYCState(error: '', isSuccess: false));
      return null;
    }
    emit(const KYCState(error: '', isSuccess: true));
  }
}
