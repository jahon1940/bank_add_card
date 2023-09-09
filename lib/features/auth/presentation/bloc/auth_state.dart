part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final Status firebaseStatus;

  const AuthState({
    this.firebaseStatus = Status.initial,
  });

  AuthState copyWith({
    Status? firebaseStatus,
  }) =>
      AuthState(
        firebaseStatus: firebaseStatus ?? this.firebaseStatus,
      );

  @override
  List<Object> get props => [];
}

enum Status { initial, loading, success, error }

extension FirebaseStatusX on Status {
  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.success;

  bool get isError => this == Status.error;
}
