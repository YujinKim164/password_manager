import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addSocial.dart';
import 'addCard.dart';

class DetailCardPage extends StatelessWidget {
  final String cardName;

  const DetailCardPage({required this.cardName});
  Future<DocumentSnapshot<Object?>?> getCard(String cardName) {
    return FirebaseFirestore.instance
        .collection('collection')
        .get()
        .then((QuerySnapshot<Object?> querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        // 문서가 존재하지 않을 때는 null을 반환합니다.
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot<Object?>?>(
        future: getCard(cardName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              var data = snapshot.data!.data();
              if (data != null) {
                var mapData = data as Map<String, dynamic>;

                var cardNumber = mapData['card_number'];
                var decodedCardNumber = decodeString(cardNumber ?? '');
                var expDate = mapData['exp'];
                var decodedExpDate = decodeString(expDate ?? '');
                var cvv = mapData['cvv'];
                var decodedCvv = decodeString(cvv ?? '');
                var cardHolder = mapData['card_holder'];
                var decodedCardHolder = decodeString(cardHolder ?? '');
                var cardPassword = mapData['password'];
                var decodedCardPassword = decodeString(cardPassword ?? '');

                return Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Text(
                              '$cardName',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 64.0,
                                color: Color(0xFFAE60E1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 120.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.credit_card, size: 25.0),
                                    SizedBox(height: 10.0),
                                    Text(
                                      '$decodedCardNumber',
                                    ),
                                    Text('$decodedExpDate'),
                                    SizedBox(width: 50.0),
                                    Text('$decodedCvv'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person, size: 25.0),
                                    SizedBox(height: 10.0),
                                    Text('$decodedCardHolder'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.lock, size: 25.0),
                                    SizedBox(height: 10.0),
                                    Text('$decodedCardPassword'),
                                  ],
                                ),
                              ],
                            ),
                            // Add other necessary information here.
                          ],
                        ),
                        SizedBox(height: 180.0), // Adjust as needed
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 157,
                              height: 47,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle Delete button press
                                },
                                child: Text('Delete'),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFFAE60E1)), // 글자 색상 설정
                                  side: MaterialStateProperty.all<BorderSide>(
                                    // 테두리 색상 설정
                                    BorderSide(color: Color(0xFFAE60E1)),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 157,
                              height: 47,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle Delete button press
                                },
                                child: Text('Update'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFAE60E1), // 버튼 색상 설정
                                ),
                              ),
                            )
                          ],
                        ),
                        // 필요한 다른 정보들도 이어서 추가하실 수 있습니다.
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('데이터를 찾을 수 없습니다.'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
