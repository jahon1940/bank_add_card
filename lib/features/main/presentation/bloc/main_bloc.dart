import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<AddCardEvent>(_addCard);
    on<DeleteCardEvent>(_deleteCard);
    on<UpdateCardEvent>(_updateCard);
  }

  Future<void> _addCard(AddCardEvent event, Emitter<MainState> emit) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('Card').doc(auth.currentUser!.uid).collection(
          'Cards').add({
        'theme': event.theme,
        'cardHolderName': event.cardHolderName,
        'cvvCode': event.cvvCode,
        'cardNumber': event.cardNumber,
        'expiryDate': event.expiryDate,
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('error----${e.code}');
      }
    }
  }

  void _deleteCard(DeleteCardEvent event, Emitter<MainState> emit) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('Card').doc(auth.currentUser!.uid).collection(
          'Cards').doc(event.cardKey).delete();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('error----${e.code}');
      }
    }
  }

  void _updateCard(UpdateCardEvent event, Emitter<MainState> emit) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      fireStore.collection('Card').doc(auth.currentUser!.uid).collection(
          'Cards').doc(event.cardKey).update({
        'theme': event.theme,
        'cardHolderName': event.cardHolderName,
        'cvvCode': event.cvvCode,
        'cardNumber': event.cardNumber,
        'expiryDate': event.expiryDate,
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('error----${e.code}');
      }
    }
  }
}
