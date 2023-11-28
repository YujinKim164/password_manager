import 'package:flutter/material.dart';
import '../Profile/my_profile.dart';
import 'addBank.dart';
import 'addCard.dart';
import 'addSocial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Please select a category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const Center(
          child: Text(
            'Welcome to the Password Manager!',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                _showCategoryDialog(context);
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: const Icon(Icons.person),
            ),
          ],
        ));
  }

  Future<void> _showCategoryDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Category'),
          content: DropdownButton<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });

              // Navigate to the corresponding page based on the selected category
              if (selectedCategory == 'social') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddSocial(),
                  ),
                );
              }
              if (selectedCategory == 'accounts') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBank()),
                );
              }
              if (selectedCategory == 'cards') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCard()),
                );
              }
            },
            items: <String>[
              'Please select a category',
              'social',
              'accounts',
              'cards'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
