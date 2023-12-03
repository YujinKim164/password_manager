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

List <int> lengthList = <int>[8, 10, 12];
int dropdownValue = lengthList.first;

class _PWGeneratorState extends State<PWGenerator> with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  String _pswd = "Generating Password";

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Password"),
      ),
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(_pswd, style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              DropdownButton<int>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (int? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: lengthList.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(), style: const TextStyle(fontSize: 16),),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _pswd = GPassword().generate(passwordLength: dropdownValue,);
                    socialPWController.text = _pswd;
                    bankPWController.text = _pswd;
                  });
                }, 
                child: Text("Generate")
              )
            ],
          ),
        ),
      ),
    );
  }
}