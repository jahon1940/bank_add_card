import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_feature_folder/constants/constants.dart';
import 'package:empty_feature_folder/features/main/presentation/mixin/mixin.dart';
import 'package:empty_feature_folder/features/main/presentation/pages/update_card_page/update_card_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import '../../bloc/main_bloc.dart';
import '../add_card_page/add_card_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainPageMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: auth.currentUser?.photoURL == null
                    ? CircleAvatar(
                        backgroundColor: AppColors.mainColor.withOpacity(0.2),
                        child: const Icon(Icons.person),
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(auth.currentUser!.photoURL!),
                      )),
            title: Text(
              auth.currentUser!.email.toString(),
              style: const TextStyle(fontSize: 15),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onPressed: () {
                  auth.signOut();
                },
              )
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Card')
                .doc(auth.currentUser!.uid)
                .collection('Cards')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data?.docs.length ?? 0) > 0) {
                  return ListView(
                    children: snapshot.data!.docs
                        .map<Widget>((doc) => _buildCardListItem(doc))
                        .toList(),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No Cards\nPlease add new Card",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddCardPage()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    data['key']=document.id;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  UpdateCardPage(
                    cardNumber: data['cardNumber'],
                    expiryDate: data['expiryDate'],
                    cardHolderName: data['cardHolderName'],
                    cvvCode: data['cvvCode'],
                    useBackgroundImage: data['theme'],
                    cardKey:data['key'],

                )));
      },
      child: CreditCardWidget(
        cardNumber: data['cardNumber'],
        expiryDate: data['expiryDate'],
        cardHolderName: data['cardHolderName'],
        cvvCode: data['cvvCode'],
        bankName: 'My Bank',
        showBackView: isCvvFocused,
        obscureCardNumber: true,
        obscureCardCvv: true,
        isHolderNameVisible: true,
        cardBgColor: AppColors.mainColor,
        backgroundImage: data['theme'],
        isSwipeGestureEnabled: true,
        onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
        customCardTypeIcons: <CustomCardTypeIcon>[
          CustomCardTypeIcon(
            cardType: CardType.mastercard,
            cardImage: Image.asset(
              'icons/mastercard.png',
              height: 48,
              width: 48,
              package: 'flutter_credit_card',
            ),
          ),
        ],
      ),
    );
  }
}
