part of 'kyc_bloc.dart';

abstract class KYCEvent extends Equatable {
  const KYCEvent();

  @override
  List<Object> get props => [];
}

class KycSubmitEvent extends KYCEvent {
  final KYCModel kycModel;

  const KycSubmitEvent({required this.kycModel});

  @override
  List<Object> get props => [kycModel];
}
