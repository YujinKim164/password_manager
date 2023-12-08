import 'package:flutter/material.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:rive/rive.dart' as rv;

import 'addSocial.dart';

Future<void> updateCard(String docRef, String cardName, String cardNumber, String exp, String cvv, String password) async{
  return await FirebaseFirestore.instance.collection('collection').doc(docRef).update({
    'thumbnail': encodeString(cardName),
    'card_name': encodeString(cardName),
    'card_number': encodeString(cardNumber),
    'cvv': encodeString(cvv),
    'exp': encodeString(exp),
    'password': encodeString(password),
  });
}

class UpdateCardPage extends StatefulWidget {
  UpdateCardPage({
    Key? key,
    required this.docRef,
    required this.cardName,
    required this.cardNumber,
    required this.exp,
    required this.cvv,
    required this.cardHolder,
    required this.password,
  }) : super(key: key);

  final String docRef;
  final String cardName;
  final String cardNumber;
  final String exp;
  final String cvv;
  final String cardHolder;
  final String password;

  @override
  _UpdateCardPageState createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
  final _cardController = TextEditingController();
  final _PWController = TextEditingController();

  final _cardNameKey = GlobalKey<FormState>();
  final _pwKey = GlobalKey<FormState>();

  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _visible = false;
  
  @override
  Widget build(BuildContext context) {
    Glassmorphism? _getGlassmorphismConfig() {
      if (!useGlassMorphism) {
        return null;
      }

      final LinearGradient gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
        stops: const <double>[0.3, 0],
      );

      return isLightTheme
          ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
          : Glassmorphism.defaultConfig();
    }

    void onCreditCardModelChange(CreditCardModel creditCardModel) {
      setState(() {
        cardNumber = creditCardModel.cardNumber;
        expiryDate = creditCardModel.expiryDate;
        cardHolderName = creditCardModel.cardHolderName;
        cvvCode = creditCardModel.cvvCode;
        isCvvFocused = creditCardModel.isCvvFocused;
      });
    }

    void init() {
      _cardController.text = widget.cardName;
      cardNumber = widget.cardNumber;
      expiryDate = widget.exp;
      cvvCode = widget.cvv;
      cardHolderName = widget.cardHolder;
      _PWController.text = widget.password;
    }

    init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                var cardDetail = await CardScanner.scanCard();
                print(cardDetail);
              },
              icon: const Icon(Icons.camera_alt_outlined)),
        ],
      ),
      body: _visible ? Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,  
            color: Colors.green,
            child: rv.RiveAnimation.asset("assets/handshake.riv", fit: BoxFit.cover,),
          ),
        )
        : Column(
        children: [
          CreditCardWidget(
            enableFloatingCard: useFloatingAnimation,
            glassmorphismConfig: _getGlassmorphismConfig(),
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            bankName: _cardController.text,
            frontCardBorder:
                useGlassMorphism ? null : Border.all(color: Colors.grey),
            backCardBorder:
                useGlassMorphism ? null : Border.all(color: Colors.grey),
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            backgroundImage: useBackgroundImage
                ? 'password_manager/assets/images/card_bg.png'
                : null,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.mastercard,
                cardImage: Image.asset(
                  'password_manager/assets/images/mastercard.png',
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                        key: _cardNameKey,
                        child: TextFormField(
                          controller: _cardController,
                          decoration: const InputDecoration(
                            labelText: "Card name",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cardname is empty";
                            }
                            return null;
                          },
                        )),
                  ),
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: false,
                    obscureNumber: false,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    inputConfiguration: const InputConfiguration(
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: InputDecoration(
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        labelText: 'Card Holder',
                      ),
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                      key: _pwKey,
                      child: TextFormField(
                        controller: _PWController,
                        decoration: const InputDecoration(
                          labelText: "password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "password is empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate() &&
                _cardNameKey.currentState!.validate() &&
                _pwKey.currentState!.validate()) {
              await updateCard(widget.docRef, _cardController.text,
                  cardNumber, expiryDate, cvvCode, _PWController.text);

              setState(() {
                _visible = !_visible;
              });
              Future.delayed(Duration(milliseconds: 3000), () {
                Navigator.pop(context);
              });
            }
          },
          child: const Text('Update'),
        ),
      ),
    );
  }
}
