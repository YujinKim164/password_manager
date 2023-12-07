import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addSocial.dart';
import 'addCard.dart';
import 'pwGenerator.dart';

final bankPWController = TextEditingController();

Future<void> updateBank(String docRef, String bankName, String cardNumber, String name, String ID, String password) async {
  return await FirebaseFirestore.instance.collection("collection").doc(docRef).update({
    'thumbnail': encodeString(bankName),
    'bank_name': encodeString(bankName),  
    'card_number': encodeString(cardNumber),
    'name': encodeString(name),
    'ID': encodeString(ID),
    'password': encodeString(password),
  });
}

class UpdateBankPage extends StatefulWidget {
  UpdateBankPage({
    Key? key,
    required this.docRef,
    required this.bankName,
    required this.cardNumber,
    required this.name,
    required this.id,
    required this.password,
  }) : super(key: key);

  final String docRef;
  final String bankName;
  final String cardNumber;
  final String name;
  final String id;
  final String password;

  @override
  _UpdateBankPageState createState() => _UpdateBankPageState();
}

class _UpdateBankPageState extends State<UpdateBankPage> {
  final _bankController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _IDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void init() {
    _bankController.text = widget.bankName;
    _numberController.text = widget.cardNumber;
    _nameController.text = widget.name;
    _IDController.text = widget.id;
    bankPWController.text = widget.password;
    };

    init();
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Form(
          key : _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _bankController,
                  decoration: const InputDecoration(
                    labelText: "Bank Name"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Bank Name is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Name of Holder"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Name is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: "Account Number"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Account Number is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _IDController,
                  decoration: const InputDecoration(
                    labelText: "Email / ID"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Email / ID is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: bankPWController,
                  decoration: const InputDecoration(
                    labelText: "Password"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Password is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

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
              await updateBank(widget.docRef,
                                _bankController.text, 
                                _nameController.text, 
                                _numberController.text,
                                _IDController.text,
                                bankPWController.text);

              Navigator.pop(context);
            }
          },
          child: const Text('Update'),
        ),
      ),
    );
  }
}
