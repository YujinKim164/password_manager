import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Home/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? user;

  @override
  void initState() {
    super.initState();
    _handleSignIn(); // 페이지가 처음 빌드될 때 사용자 정보를 가져옴
  }

  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      user = authResult.user;
      setState(() {});
      return user;
    } catch (error) {
      return null;
    }
  }

  Future<void> _signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user != null) ...[
              if (user!.photoURL != null) Image.network(user!.photoURL!),
              Text('$user!.displayName ?? ""'),
              Text('${user!.email ?? ""}'),
            ],
            const SizedBox(height: 80.0), // Buttons
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Update Profile logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UpdatePage()),
                  );
                },
                child: const Text('Update Profile'),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Auto Settings logic
                },
                child: Text('Auto Settings'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Switch to Dark Mode logic
                },
                child: Text('Switch to Dark Mode'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  _signOut(); // Logout logic
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
