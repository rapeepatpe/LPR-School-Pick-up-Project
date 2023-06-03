part of 'login_choice_bloc.dart';

abstract class LoginChoiceEvent extends Equatable {
  const LoginChoiceEvent();

  @override
  List<Object> get props => [];
}

class LoginChoiceEventSelectInput extends LoginChoiceEvent {}

class LoginChoiceEventSelectQR extends LoginChoiceEvent {}

class LoginChoiceEventConnectViaSchoolEvent extends LoginChoiceEvent {}

class LoginChoiceEventConnectViaUserpass extends LoginChoiceEvent {}

class LoginChoiceEventConnectViaQR extends LoginChoiceEvent {}
