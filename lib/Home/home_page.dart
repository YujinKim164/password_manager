import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryCard(
                context,
                'Socials',
                Icons.people,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddSocial()),
                  );
                },
              ),
              _buildCategoryCard(
                context,
                'Accounts',
                Icons.account_balance_wallet,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBank()),
                  );
                },
              ),
              _buildCategoryCard(
                context,
                'Cards',
                Icons.credit_card,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCard()),
                  );
                },
              ),
            ],
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('collection').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      var document = documents[index];
                      // Check if 'app_name' field exists in the document
                      if (document.data() != null &&
                          document.data() is Map &&
                          (document.data() as Map).containsKey('app_name')) {
                        var appName = document['app_name'];
                        var decodedAppName = decodeString(appName);
                        return _buildCategoryCard(
                          context,
                          decodedAppName,
                          Icons.facebook, // Replace with the appropriate icon
                          () {
                            // Add your logic when the card is tapped
                          },
                        );
                      } else {
                        // Handle the case where 'app_name' field is not present
                        return Container();
                      }
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String categoryName,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Container(
          height: 120.0, // Set the desired height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0),
              const SizedBox(height: 8.0),
              Text(
                categoryName,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
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
