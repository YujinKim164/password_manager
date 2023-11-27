import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addSocial.dart';
import 'addSocial.dart';
import 'addBank.dart';
import 'pwGenerator.dart';

final cardPWController = TextEditingController();

class AddCard extends StatefulWidget {
  AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> with ChangeNotifier {
  final _cardController = TextEditingController();
  final _numberController = TextEditingController();
  final _EXPController = TextEditingController();
  final _CVVController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<DocumentReference> addCard(String cardName, String cardNumber, String exp, String cvv, String pswd) async {
    return FirebaseFirestore.instance
      .collection('collection')
      .add(<String, dynamic>{
        'thumbnail': encodeString(cardName),
        'card_name': encodeString(cardName),
        'card_number': encodeString(cardNumber),
        'exp': encodeString(exp),
        'cvv': encodeString(cvv),
        'password': encodeString(pswd),
        'favorites': 0
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Card account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key : _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: _cardController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Card Name"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Card Name is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Credit Card Number"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Card number is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: _EXPController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("EXP Date(MM/YY)"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "EXP date empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: _CVVController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("CVV"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "CVV is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: TextFormField(
                  controller: cardPWController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Password"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Password is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),

              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PWGenerator()));
                  },
                  child: const Text("Generate"),
                ),
              )
            ],
          ),
        )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState!.validate()) {
              DocumentReference docRef = await addCard(_cardController.text, 
                                                _numberController.text,
                                                _EXPController.text,
                                                _CVVController.text,
                                                cardPWController.text);

              _cardController.clear();
              _numberController.clear();
              _EXPController.clear();
              _CVVController.clear();
              socialPWController.clear();
              bankPWController.clear();
              cardPWController.clear();
            }
          },
          child: const Text('Create New'),
        ),
      ),
    );
  }
}
