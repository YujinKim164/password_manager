import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../Profile/my_profile.dart';
import 'addBank.dart';
import 'addCard.dart';
import 'addSocial.dart';
import 'detailBank.dart';
import 'detailCard.dart';
import 'detailSocial.dart';

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
                      List<Widget> cardList = [];

                      if (document.data() != null && document.data() is Map) {
                        var data = document.data() as Map;

                        // Social
                        if (data.containsKey('app_name')) {
                          var appName = data['app_name'];
                          var decodedAppName = decodeString(appName);
                          var mapData = data as Map<String, dynamic>;
                          var socialappLink = mapData['appLink'];
                          var decodedSocialappLink =
                              decodeString(socialappLink);
                          var socialId = mapData['ID'];
                          var decodedSocialId = decodeString(socialId);
                          var socialPassword = mapData['password'];
                          var decodedSocialPassword =
                              decodeString(socialPassword);
                          if (decodedAppName != null) {
                            var cardWidget = _passwordCard(
                              context,
                              decodedAppName,
                              Icons.people,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailSocialPage(
                                      docRef:
                                          'document.id', // Use the actual document ID
                                      appName: decodedAppName,
                                      appLink: decodedSocialappLink,
                                      id: decodedSocialId,
                                      password: decodedSocialPassword,
                                    ),
                                  ),
                                );
                              },
                            );
                            cardList.add(cardWidget);
                          }
                        }
                        // Bank Account
                        if (data.containsKey('bank_name')) {
                          var bankName = data['bank_name'];
                          var decodedBankName = decodeString(bankName);
                          var mapData = data as Map<String, dynamic>;
                          var holderName = mapData['name'];
                          var decodedHolder = decodeString(holderName);
                          var bankId = mapData['ID'];
                          var decodedBankId = decodeString(bankId);
                          var bankNumber = mapData['card_number'];
                          var decodedBankNumber = decodeString(bankNumber);
                          var bankPassword = mapData['password'];
                          var decodedBankPassword = decodeString(bankPassword);
                          if (decodedBankName != null) {
                            var cardWidget = _passwordCard(
                              context,
                              decodedBankName,
                              Icons.attach_money,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailBankPage(
                                      docRef:
                                          'document.id', // Use the actual document ID
                                      bankName: decodedBankName,
                                      cardNumber: decodedBankNumber,
                                      name: decodedHolder,
                                      id: decodedBankId,
                                      password: decodedBankPassword,
                                    ),
                                  ),
                                );
                              },
                            );
                            cardList.add(cardWidget);
                          }
                        }
                        // Card
                        if (data.containsKey('card_name')) {
                          var cardName = data['card_name'];
                          var decodedCardName = decodeString(cardName);
                          if (decodedCardName != null) {
                            var cardWidget = _passwordCard(
                              context,
                              decodedCardName,
                              Icons.credit_card,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailCardPage(
                                      cardName: decodedCardName,
                                    ),
                                  ),
                                );
                              },
                            );
                            cardList.add(cardWidget);
                          }
                        }
                      }

                      return Column(
                        children: cardList,
                      );
                    },
                  ),
                );
              } else {
                return const Center(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.all(16.0),
        child: Container(
          width: 93.0,
          height: 124.0, // Set the desired height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 35.0),
              const SizedBox(height: 8.0),
              Text(
                categoryName,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordCard(
    BuildContext context,
    String categoryName,
    IconData icon,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Container(
          width: 335.0,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10.0),
              Icon(icon, size: 35.0),
              const SizedBox(width: 18.0),
              Text(
                categoryName,
                style: TextStyle(fontSize: 20.0),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.content_copy, color: Color(0xFFAE60E1)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: 'password'));
                },
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
              if (newValue != null) {
                setState(() {
                  selectedCategory = newValue;
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
