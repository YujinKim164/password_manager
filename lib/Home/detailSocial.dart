import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addSocial.dart';
import 'updateSocial.dart';

class DetailSocialPage extends StatefulWidget {
  final String appName;
  final String docRef;
  final String appLink;
  final String id;
  final String password;

  const DetailSocialPage({
    Key? key,
    required this.docRef,
    required this.appName,
    required this.appLink,
    required this.id,
    required this.password,
  }) : super(key: key);

  @override
  _DetailSocialPageState createState() => _DetailSocialPageState();
}

class _DetailSocialPageState extends State<DetailSocialPage> {
  bool _isHidden = true;

  Future<DocumentSnapshot<Object?>?> getSocial(String appName) {
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
        future: getSocial(widget.appName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              var data = snapshot.data!.data();
              if (data != null) {
                var mapData = data as Map<String, dynamic>;
                var appName = mapData['app_name'];
                var decodedAppName = decodeString(appName);
                var socialappLink = mapData['appLink'];
                var decodedSocialappLink = decodeString(socialappLink);
                var socialId = mapData['ID'];
                var decodedSocialId = decodeString(socialId);
                var socialPassword = mapData['password'];
                var decodedSocialPassword = decodeString(socialPassword);

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
                              '${decodedAppName}',
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
                                      '$decodedSocialappLink',
                                    ),
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
                                    Text('$decodedSocialId'),
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
                                    Text(
                                      _isHidden
                                          ? '${'*' * decodedSocialPassword.length}'
                                          : '$decodedSocialPassword',
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xFFAE60E1),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                              ],
                            ),
                            // Add other necessary information here.
                          ],
                        ),
                        SizedBox(height: 180.0),
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
                                          Color(0xFFAE60E1)),
                                  side: MaterialStateProperty.all<BorderSide>(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateSocialPage(
                                        docRef: 'widget.docRef',
                                        appName: decodedAppName,
                                        link: decodedSocialappLink,
                                        id: decodedSocialId,
                                        password: decodedSocialPassword,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Update'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFAE60E1),
                                ),
                              ),
                            ),
                          ],
                        ),
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
