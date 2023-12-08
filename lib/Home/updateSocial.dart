import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'pwGenerator.dart';
import 'addSocial.dart';
import 'addBank.dart';

Future<void> updateSocial(String docRef, String appName, String link, String id, String password) async {
  return await FirebaseFirestore.instance.collection('collection').doc(docRef).update({
    'thumbnail': encodeString(appName),
    'app_name': encodeString(appName),
    'link': encodeString(link),
    'ID': encodeString(id),
    'password': encodeString(password),
  });
}

class UpdateSocialPage extends StatefulWidget {
  const UpdateSocialPage({
    Key? key,
    required this.docRef,
    required this.appName,
    required this.link,
    required this.id,
    required this.password,
  }) : super(key: key);

  final String docRef;
  final String appName;
  final String link;
  final String id;
  final String password;

  @override
  _UpdateSocialPageState createState() => _UpdateSocialPageState();
}

class _UpdateSocialPageState extends State<UpdateSocialPage> {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _IDController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _visible = false;
  
  @override
  Widget build(BuildContext context) {
    void init() {
      _nameController.text = widget.appName;
      _urlController.text = widget.link;
      _IDController.text = widget.id;
      socialPWController.text = widget.password;
    };

    init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
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
              await updateSocial(widget.docRef,
                                _nameController.text, 
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
