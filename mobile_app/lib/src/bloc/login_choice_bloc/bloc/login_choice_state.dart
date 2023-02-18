part of 'login_choice_bloc.dart';

abstract class LoginChoiceState extends Equatable {
  const LoginChoiceState({this.schoolUrl, this.username, this.password});

  final String? schoolUrl;
  final String? username;
  final String? password;

  @override
  List<Object> get props => [];
}

class LoginChoiceInput extends LoginChoiceState {}

class LoginChoiceQR extends LoginChoiceState {}
