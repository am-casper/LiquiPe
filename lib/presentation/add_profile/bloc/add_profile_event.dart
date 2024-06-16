part of 'add_profile_bloc.dart';

abstract class AddProfileEvent extends Equatable {}

class ProfileSubmitEvent extends AddProfileEvent {
  final UserModel userModel;

  ProfileSubmitEvent({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
