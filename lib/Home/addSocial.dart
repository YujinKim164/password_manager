import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Home/addBank.dart';
import 'package:password_manager/Home/addCard.dart';
import 'package:provider/provider.dart';
import 'package:encrypt/encrypt.dart'as en;

import 'package:password_manager/app_state.dart';
import 'pwGenerator.dart';

final socialPWController = TextEditingController();

String encodeString(String text) {

  final key = en.Key.fromUtf8("XyZaBcDeFgHiJkLm");
  final iv = en.IV.fromLength(16);
  final encrypter = en.Encrypter(en.AES(key, mode:en.AESMode.cbc));

  return encrypter.encrypt(text, iv:iv).base64;
}

String decodeString(String text) {

  final key = en.Key.fromUtf8("XyZaBcDeFgHiJkLm");
  final iv = en.IV.fromLength(16);
  final encrypter = en.Encrypter(en.AES(key, mode:en.AESMode.cbc));
  
  return encrypter.decrypt64(text, iv:iv);
}

class AddSocial extends StatefulWidget {
  AddSocial({Key? key}) : super(key: key);

  @override
  _AddSocialState createState() => _AddSocialState();
}

class _AddSocialState extends State<AddSocial> with ChangeNotifier {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _IDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<DocumentReference> addSocial(String appName, String appLink, String ID, String pswd) async {
    return FirebaseFirestore.instance
      .collection('collection')
      .add(<String, dynamic>{
        'thumbnail': encodeString(appName),
        'app_name': encodeString(appName),
        'link': encodeString(appLink),
        'ID': encodeString(ID),
        'password': encodeString(pswd),
        'favorites': 0
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Social account"),
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Website / App Name"),
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
                  controller: _urlController,
                  decoration: InputDecoration(
                    filled: true,
                    label: const Text("Website / AppLink"),
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
                  controller: socialPWController,
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
        child:  ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState!.validate()) {
              DocumentReference docRef = await addSocial(_nameController.text, 
                                                        _urlController.text,
                                                        _IDController.text,
                                                        socialPWController.text);

              // print(decodeString(encodeString(_nameController.text)));
              // print(decodeString(encodeString(_urlController.text)));
              // print(decodeString(encodeString(_IDController.text)));
              // print(decodeString(encodeString(socialPWController.text)));
              
              _nameController.clear();
              _urlController.clear();
              _IDController.clear();
              socialPWController.clear();
              bankPWController.clear();
              cardPWController.clear();
            }
          },
          child: const Text('Create New'),
        )
      ),
    );
  }
}
