part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class AddCardEvent extends MainEvent {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvvCode;
  final String theme;

  AddCardEvent({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.theme,
  });

  @override
  List<Object?> get props => [];
}

class DeleteCardEvent extends MainEvent {
  final String cardKey;
  DeleteCardEvent({
    required this.cardKey
});

  @override
  List<Object?> get props => [];
}

class UpdateCardEvent extends MainEvent {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvvCode;
  final String theme;
  final String cardKey;
  UpdateCardEvent({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.theme,
    required this.cardKey
  });

  @override
  List<Object?> get props => [];
}
