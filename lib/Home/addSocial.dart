import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pwGenerator.dart';

class AddSocial extends StatefulWidget {
  AddSocial({Key? key}) : super(key: key);

  @override
  _AddSocialState createState() => _AddSocialState();
}

class _AddSocialState extends State<AddSocial> with ChangeNotifier {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _IDController = TextEditingController();
  final _PWController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
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
          onPressed: () {
            if(_formKey.currentState!.validate()) {
              print(_nameController.text);
              print(_urlController.text);
              print(_IDController.text);
              print(_PWController.text);

              _nameController.clear();
              _urlController.clear();
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
