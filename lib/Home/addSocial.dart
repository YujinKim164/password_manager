import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSocial extends StatefulWidget {
  AddSocial({Key? key}) : super(key: key);

  @override
  _AddSocialState createState() => _AddSocialState();
}

class _AddSocialState extends State<AddSocial> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Social account"),
      ),
    );
  }
}
