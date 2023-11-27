import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gpassword/gpassword.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addSocial.dart';
import 'addBank.dart';
import 'addCard.dart';

class PWGenerator extends StatefulWidget {
  PWGenerator({Key? key}) : super(key: key);

  @override
  _PWGeneratorState createState() => _PWGeneratorState();
}

class _PWGeneratorState extends State<PWGenerator> with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  String _pswd = "Generating Password";

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Password"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_pswd),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pswd = GPassword().generate();
                socialPWController.text = _pswd;
                bankPWController.text = _pswd;
                cardPWController.text = _pswd;
              });
            }, 
            child: Text("Generate")
            )
        ],
      ),
    );
  }
}