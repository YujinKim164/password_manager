import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'addSocial.dart';
import 'addCard.dart';
import 'pwGenerator.dart';

final bankPWController = TextEditingController();

class AddBank extends StatefulWidget {
  AddBank({Key? key}) : super(key: key);

  @override
  _AddBankState createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> with ChangeNotifier {
  final _bankController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _IDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _visible = false;

  Future<DocumentReference> addBank(String bankName, String name,
      String accountNumber, String id, String pswd) async {
    return FirebaseFirestore.instance
        .collection('collection')
        .add(<String, dynamic>{
      'thumbnail': encodeString(bankName),
      'bank_name': encodeString(bankName),
      'name': encodeString(name),
      'card_number': encodeString(accountNumber),
      'ID': encodeString(id),
      'password': encodeString(pswd),
      'favorites': 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bank account"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            socialPWController.text = "";
            bankPWController.text = "";
            Navigator.pop(context);
          },
        ),
      ),
      body: _visible ? Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,  
            color: Colors.green,
            child: RiveAnimation.asset("assets/handshake.riv", fit: BoxFit.cover,),
          ),
        )
        : Padding(
          padding: const EdgeInsets.all(4.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: _bankController,
                    decoration: const InputDecoration(labelText: "Bank Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bank Name is empty.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: "Name of Holder"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is empty.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: _numberController,
                    decoration:
                        const InputDecoration(labelText: "Account Number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Account Number is empty.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: _IDController,
                    decoration: const InputDecoration(labelText: "Email / ID"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email / ID is empty.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: bankPWController,
                    decoration: const InputDecoration(labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is empty.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PWGenerator()));
                    },
                    child: const Text("Generate"),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              DocumentReference docRef = await addBank(
                  _bankController.text,
                  _nameController.text,
                  _numberController.text,
                  _IDController.text,
                  bankPWController.text);

              setState(() {
                _visible = !_visible;
              });
              Future.delayed(Duration(milliseconds: 3000), () {
                Navigator.pop(context);
              });
            }
          },
          child: const Text('Create New'),
        ),
      ),
    );
  }
}
