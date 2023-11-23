import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addSocial.dart';
import 'pwGenerator.dart';

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
  final _PWController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<DocumentReference> addBank(String bankName, String name, String accountNumber, String ID, String pswd) async {
    return FirebaseFirestore.instance
      .collection('collection')
      .add(<String, dynamic>{
        'thumbnail': encodeString(bankName),
        'bank_name': encodeString(bankName),
        'name': encodeString(name),
        'card_number': encodeString(accountNumber),
        'ID': encodeString(ID),
        'password': encodeString(pswd),
        'favorites': 0
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bank account"),
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
                  controller: _bankController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Bank Name"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Bank Name is empty.";
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Name of Holder"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Name is empty.";
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
                    label: const Text("Account Number"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "URL is empty.";
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
                  controller: _IDController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Email / ID"),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "ID is empty.";
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
                  controller: _PWController,
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
              DocumentReference docRef = await addBank(_bankController.text, 
                                                      _nameController.text, 
                                                      _numberController.text,
                                                      _IDController.text,
                                                      _PWController.text);

              _bankController.clear();
              _nameController.clear();
              _numberController.clear();
              _IDController.clear();
              _PWController.clear();
            }
          },
          child: const Text('Create New'),
        ),
      ),
    );
  }
}
