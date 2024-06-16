part of 'kyc_bloc.dart';

class KYCState extends Equatable {
  final String error;
  final bool isSuccess;

  const KYCState({required this.error, required this.isSuccess});

  factory KYCState.initial() {
    return const KYCState(error: '', isSuccess: false);
  }
  @override
  List<Object> get props => [isSuccess, error];
}
