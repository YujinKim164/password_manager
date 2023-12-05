import 'package:flutter/material.dart';
import 'package:password_manager/home/home_page.dart';
import '../Profile/my_profile.dart';

class UpdateSocialPage extends StatefulWidget {
  const UpdateSocialPage({Key? key}) : super(key: key);

  @override
  _UpdateSocialPageState createState() => _UpdateSocialPageState();
}

class _UpdateSocialPageState extends State<UpdateSocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE'),
      ),
      body: const Center(
        child: Text(
          'You can edit your accounts here!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: const Icon(Icons.person),
      ),
    );
  }
}
