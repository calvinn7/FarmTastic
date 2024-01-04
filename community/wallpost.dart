// ignore_for_file: prefer_const_constructors

import 'package:farmtastic/features/authentication/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/likebutton.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String email;
  final String title;
  final String userId;
  // final String time;
  final String postId;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.email,
    required this.title,
    required this.userId,
    // required this.time,
    required this.likes,
    required this.postId,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  // user from firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.uid);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.userId)
        .collection("Posts")
        .doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.uid])
      }).then((_) {
        print('Added like');
      }).catchError((error) {
        print('Error adding like: $error');
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.uid])
      }).then((_) {
        print('Removed like');
      }).catchError((error) {
        print('Error removing like: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 25.0,
            spreadRadius: 5.0,
          ),
        ],
        color: Color.fromARGB(255, 238, 247, 194),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // like button
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              const SizedBox(height: 5),

              // like count
              Text(widget.likes.length.toString()),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile pic and email row
                Row(
                  children: [
                    // Profile pic
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                      padding: EdgeInsets.all(6),
                      width: 36,
                      height: 36,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    // Email
                    Text(widget.email,
                        style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  widget.title,
                  softWrap: true,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Message
                Text(
                  widget.message,
                  softWrap: true,
                  style: TextStyle(fontSize: 16), // Adjust font size as needed
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
