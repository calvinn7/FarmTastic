// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/authentication/user_model.dart';
import 'features/controllers/profile_controller.dart';
import 'wallpost.dart';
import 'postinghistory.dart';

class Posting extends StatefulWidget {
  const Posting({super.key});

  @override
  _PostingState createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  postMessage(UserModel user) {
    // only post if there is something in the textfield
    if (titleController.text.isNotEmpty) {
      // store in firebase
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.id)
          .collection("Posts")
          .add({
        'Email': user.email,
        'Title': titleController.text,
        'Message': messageController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // clear textfield
    setState(() {
      titleController.clear();
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('POST'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 249, 255, 223),
        ),
        body: Center(
          child: Column(children: [
            // the wall
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup("Posts")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data!.docs[index];

                          return FutureBuilder<DocumentSnapshot>(
                            future: post.reference.parent?.parent?.get(),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // or a loading indicator
                              } else if (userSnapshot.hasError) {
                                return Text('Error: ${userSnapshot.error}');
                              } else if (!userSnapshot.hasData ||
                                  userSnapshot.data == null) {
                                return Text('User not found');
                              } else {
                                final userData = userSnapshot.data!;
                                return WallPost(
                                  message: post['Message'],
                                  email: post['Email'],
                                  title: post['Title'],
                                  userId: userData.id,
                                  postId: post.id,
                                  likes: List<String>.from(post['Likes'] ?? []),
                                );
                              }
                            },
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: Icon(Icons.add_circle),
                iconSize: 90.0,
                color: Color.fromARGB(255, 86, 125, 1),
                onPressed: () {
                  // Add the action for the IconButton here
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('Post Message'),
                          content: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      hintText: 'Title',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      hintText: 'Write something...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {
                                      postMessage(ProfileController
                                          .instance.userData.value!);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Post'),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ]),
        ));
  }
}
