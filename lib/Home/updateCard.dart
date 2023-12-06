import 'package:flutter/material.dart';
import 'package:password_manager/home/home_page.dart';
import '../Profile/my_profile.dart';

class UpdateCardPage extends StatefulWidget {
  const UpdateCardPage({Key? key}) : super(key: key);

  @override
  _UpdateCardPageState createState() => _UpdateCardPageState();
}

class _UpdateCardPageState extends State<UpdateCardPage> {
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
