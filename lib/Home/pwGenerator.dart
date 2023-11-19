import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PWGenerator extends StatefulWidget {
  PWGenerator({Key? key}) : super(key: key);

  @override
  _PWGeneratorState createState() => _PWGeneratorState();
}

class _PWGeneratorState extends State<PWGenerator> with ChangeNotifier {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Password"),
      ),
    );
  }
}