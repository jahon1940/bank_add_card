part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

//Sign up and Sign in with Google
class SignUpGoogleEvent extends AuthEvent {
  SignUpGoogleEvent();

  @override
  List<Object?> get props {
    return [];
  }
}
//Sign in with Email
class SignInEmailEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEmailEvent({required this.email, required this.password});

  @override
  List<Object?> get props {
    return [];
  }
}
//Sign up with Email
class SignUpEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;


  SignUpEmailEvent({required this.email, required this.password, required this.name, });

  @override
  List<Object?> get props {
    return [];
  }
}


