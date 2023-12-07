// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import "Home/register.dart";
import 'Home/home_page.dart';
import 'Home/updateCard.dart';
import 'Home/updateBank.dart';
import 'Home/updateSocial.dart';
import 'Home/addSocial.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/locked.png'),
              const SizedBox(height: 120.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Sign in with Google'),
                onPressed: () {
                  signInWithGoogle();
                },
              ),
              ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }, 
                child: const Text('Next')
              ),
              ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                }, 
                child: const Text('Register')
              ),
              ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateCardPage(docRef: "xaA46a6arJObmgsrTgWz", 
                      cardName: decodeString("OZDnzsHvMCcjnU1nuRXygQ=="),
                      cardNumber: decodeString("W3Fbdvu5PNbhOU5kXGU+HsYtKINn2iCC2oDg3oq8pno="),
                      exp: decodeString("1HITFNaKjHvEWGKynGMxxw=="),
                      cvv: decodeString("bF56HS9eGQCRVYUOi9pAQw=="),
                      cardHolder: decodeString("hzslC/a5DcW9jULj4QD+Ww=="),
                      password: decodeString("RUZB4WE2TKrzTIdcDvW7jQ==")
                    ))
                  );
                }, 
                child: const Text("UpdateCard")
              ),
              ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateBankPage(docRef: "47evP7Z3NgXk72RLlbNp",
                      bankName: decodeString("etSs6sSwvZBvQOTucSYYBw=="),
                      cardNumber: decodeString("jlAIK3C4+AeSo6yQ04xeZA=="),
                      name: decodeString("3OR8YLbBWkO3F8yKgc+BGg=="),
                      id: decodeString("7ZW7taESp15hpRb2tiSFvQ=="),
                      password: decodeString("2gJ1mnS1BzzWK7DrNTFsAg=="),
                      ))
                  );
                }, 
                child: const Text("UpdateBank")
              ),
              ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateSocialPage(docRef: "UfsciS0QOdgZLGkAmD5X",
                      appName: decodeString("L/4kf93AJPCtCuvYkX9f9w=="),
                      link: decodeString("evMZLPDtJMFe4W4v/PfW866+HyLFnAETQ0snzkvwSI8="),
                      id: decodeString("7ZW7taESp15hpRb2tiSFvQ=="),
                      password: decodeString("yUiapJi0Nraplq8B0HheYg=="),))
                  );
                }, 
                child: const Text("UpdateSocial")
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Check if googleUser is not null before proceeding
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await _auth.signInWithCredential(credential);
        final user = userCredential.user;

        // Firestore에 data 추가
        await FirebaseFirestore.instance.collection('user').doc(user?.uid).set({
          'uid': user?.uid,
          'name': user?.displayName,
          'email': user?.email,
        });

        await _auth.signInWithCredential(credential);

        print("Signed in with Google account.");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print("Google Sign-In Error: Google user is null");
      }
    } catch (e, stackTrace) {
      print("Google Sign-In Error: $e");
      print(stackTrace);
    }
  }
}
