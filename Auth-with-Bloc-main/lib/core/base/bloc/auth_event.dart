part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String userName;
  final String password;

  const LoginRequested(this.userName, this.password);

  @override
  List<Object?> get props => [userName, password];
}

class LogoutRequested extends AuthEvent {}
