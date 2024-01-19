import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/features/profile_controller.dart';


class EditPostScreen extends StatelessWidget {
  final String postId;
  final String currentTitle;
  final String currentMessage;
  late ProfileController controller;

  EditPostScreen({
    required this.postId,
    required this.currentTitle,
    required this.currentMessage,
  });

  
  Future<void> updatePost(
    String postId, String newTitle, String newMessage) async {
    controller = Get.put(ProfileController());
    await controller.getUserData();
    
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(controller.userData.value!.id)
          .collection("Posts")
          .doc(postId)
          .update({
        'Title': newTitle,
        'Message': newMessage,
      });
    } catch (e) {
      print("Error updating post: $e");
    }
  }

   @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: currentTitle);
    final TextEditingController messageController =
        TextEditingController(text: currentMessage);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await updatePost(
                  postId,
                  titleController.text,
                  messageController.text,
                );
                Navigator.pop(context, true); // Go back to previous screen
              },
              child: Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
  }
