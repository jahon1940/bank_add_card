part of 'main_bloc.dart';


class MainState extends Equatable {
  final Status firebaseStatus;

   const MainState({
    this.firebaseStatus = Status.initial,
  });

  MainState copyWith({
    Status? firebaseStatus,
  }) =>
      MainState(
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

