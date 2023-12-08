import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'package:rive/rive.dart';
import 'package:pointycastle/pointycastle.dart' as pt;

import 'pwGenerator.dart';
import 'addBank.dart';

final socialPWController = TextEditingController();
const ekey = "abcdefghijtuvwxyz1234klmnopqrs56";

Uint8List padBlock(Uint8List input, int blockSize) {
  final padLength = blockSize - (input.length % blockSize);
  final padded = Uint8List(input.length + padLength);
  padded.setAll(0, input);
  for (var i = input.length; i < padded.length; i++) {
    padded[i] = padLength;
  }
  return padded;
}

Uint8List removePadding(Uint8List input) {
  final padLength = input.last;
  return input.sublist(0, input.length - padLength);
}

Uint8List encryptBytes(pt.BlockCipher cipher, Uint8List input) {
  final blockSize = cipher.blockSize;
  final paddedInput = padBlock(input, blockSize);
  final result = Uint8List(paddedInput.length);
  for (var i = 0; i < paddedInput.length; i += blockSize) {
    cipher.processBlock(paddedInput, i, result, i);
  }
  return result;
}

Uint8List decryptBytes(pt.BlockCipher cipher, Uint8List input) {
  final blockSize = cipher.blockSize;
  final result = Uint8List(input.length);
  for (var i = 0; i < input.length; i += blockSize) {
    cipher.processBlock(input, i, result, i);
  }
  return removePadding(result);
}

String encodeString(String text) {
  final keyBytes = Uint8List.fromList(utf8.encode(ekey));
  final iv = Uint8List(16);
  final cipher = pt.BlockCipher("AES/CBC")..init(true, pt.ParametersWithIV(pt.KeyParameter(keyBytes), iv));

  final inputBytes = Uint8List.fromList(utf8.encode(text));
  final encryptedBytes = encryptBytes(cipher, inputBytes);

  final encryptedText = base64.encode(encryptedBytes);

  return encryptedText;
}

String decodeString(String encrpyted) {
  final keyBytes = Uint8List.fromList(utf8.encode(ekey));
  final iv = Uint8List(16);
  final cipher = pt.BlockCipher("AES/CBC")..init(false, pt.ParametersWithIV(pt.KeyParameter(keyBytes), iv));

  final encryptedBytes = base64.decode(encrpyted);
  final decryptedBytes = decryptBytes(cipher, encryptedBytes);

  final decryptedText = utf8.decode(decryptedBytes);

  return decryptedText;
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

  bool _visible = false;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            socialPWController.text = "";
            bankPWController.text = "";
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _visible ? Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,  
            color: Colors.green,
            child: RiveAnimation.asset("assets/handshake.riv", fit: BoxFit.cover,),
          ),
        )
        : Form(
          key : _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Website / App Name"
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
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: "Website / App Link"
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "URL is empty.";
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
                      return "Email/ID is empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: socialPWController,
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
        child:  ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState!.validate()) {
              DocumentReference docRef = await addSocial(_nameController.text, 
                                                        _urlController.text,
                                                        _IDController.text,
                                                        socialPWController.text);

              setState(() {
                _visible = !_visible;
              });
              Future.delayed(Duration(milliseconds: 3000), () {
                Navigator.pop(context);
              });
            }
          },
          child: const Text('Create New'),
        )
      ),
    );
  }
}
