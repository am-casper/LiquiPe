part of 'add_profile_bloc.dart';

class AddProfileState extends Equatable {
  final String error;
  const AddProfileState(this.error);

  @override
  List<Object> get props => [error];
}


class ProfileSubmittedState extends AddProfileState {
  const ProfileSubmittedState(super.error);
}
