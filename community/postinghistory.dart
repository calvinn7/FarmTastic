import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/features/profile_controller.dart';

import 'editHis.dart';

class postinghistory extends StatefulWidget {
  @override
  _postinghistoryState createState() => _postinghistoryState();
}

class _postinghistoryState extends State<postinghistory> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late ProfileController controller;
  late Future<List<DocumentSnapshot>> userPostsFuture;

  Future<List<DocumentSnapshot>> getUserPosts() async {
    controller = Get.put(ProfileController());
    await controller.getUserData(); // Fetch user data here

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(controller.userData.value!.id)
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .get();
    return querySnapshot.docs;
  }

  Future<void> initializeControllerAndGetUserData() async {
    controller = Get.put(ProfileController());
    await controller.getUserData(); // Fetch user data here
  }

  @override
  void initState() {
    super.initState();
    userPostsFuture = getUserPosts();
  }

  void deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(controller.userData.value!.id)
          .collection("Posts")
          .doc(postId)
          .delete();
      setState(() {
        // Refresh the UI after deletion
        userPostsFuture = getUserPosts();
      });
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Your Posts'),
        backgroundColor: const Color(0xFFF9FFDF),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),

          fontSize: 20.0, // Set the text size

          fontWeight: FontWeight.w900, // Set the font weight
        ),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: userPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var post = snapshot.data![index].data() as Map<String, dynamic>;
                String postId = snapshot.data![index].id; // Get the post ID

                return ListTile(
                  title: Text('Title: ${post['Title']}'),
                  subtitle: Text('Message: ${post['Message']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Navigate to a new screen to edit the post
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPostScreen(
                                postId: postId,
                                currentTitle: post['Title'],
                                currentMessage: post['Message'],
                              ),
                            ),
                          ).then((value) {
                            if (value != null && value) {
                              setState(() {
                                // Refresh the UI after editing the post
                                userPostsFuture = getUserPosts();
                              });
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deletePost(postId);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
