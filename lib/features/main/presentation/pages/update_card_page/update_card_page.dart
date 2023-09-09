import 'package:empty_feature_folder/constants/constants.dart';
import 'package:empty_feature_folder/features/auth/presentation/widgets/global_button.dart';
import 'package:empty_feature_folder/features/main/presentation/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../../../../routes/name_routes.dart';
import '../../mixin/mixin.dart';

class UpdateCardPage extends StatefulWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String useBackgroundImage;
  final String cardKey;

  const UpdateCardPage(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.useBackgroundImage,
      required this.cardKey,
      super.key});

  @override
  State<StatefulWidget> createState() => UpdateCardPageState();
}

class UpdateCardPageState extends State<UpdateCardPage> with MainPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<MainBloc>()
                    .add(DeleteCardEvent(cardKey: widget.cardKey));
                Navigator.pushNamed(context, RouteName.mainPage);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber == '' ? widget.cardNumber : cardNumber,
            expiryDate: expiryDate == '' ? widget.expiryDate : expiryDate,
            cardHolderName:
                cardHolderName == '' ? widget.cardHolderName : cardHolderName,
            cvvCode: cardHolderName == '' ? widget.cvvCode : cardHolderName,
            bankName: 'My Bank',
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            cardBgColor: AppColors.mainColor,
            backgroundImage: useBackgroundImage ?? widget.useBackgroundImage,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.uzcard,
                cardImage: Image.asset(
                  'assets/icons/uzcard.png',
                  height: 48,
                  width: 48,
                ),
              ),
              CustomCardTypeIcon(
                cardType: CardType.humo,
                cardImage: Image.asset(
                  'assets/icons/humo.png',
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    useBackgroundImage = 'assets/images/card_bg.png';
                  });
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.mainColor.withOpacity(0.2),
                  backgroundImage: AssetImage('assets/images/card_bg.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        useBackgroundImage = 'assets/images/card_bg2.png';
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.mainColor.withOpacity(0.2),
                      backgroundImage: AssetImage('assets/images/card_bg2.png'),
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      useBackgroundImage = 'assets/images/card_bg3.png';
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.mainColor.withOpacity(0.2),
                    backgroundImage: AssetImage('assets/images/card_bg3.png'),
                  )),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: AppColors.mainColor,
                    cardNumberDecoration: const InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: const InputDecoration(
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: const InputDecoration(
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: GlobalButton(
                        buttonName: 'Update Card',
                        onTap: () {
                          bool isValid = formKey.currentState!.validate();
                          if (isValid == false) return;
                          context.read<MainBloc>().add(UpdateCardEvent(
                              cardHolderName: cardHolderName,
                              cardNumber: cardNumber,
                              expiryDate: expiryDate,
                              cvvCode: cvvCode,
                              theme: useBackgroundImage!,
                              cardKey: widget.cardKey));

                          Navigator.pushNamed(context, RouteName.mainPage);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
