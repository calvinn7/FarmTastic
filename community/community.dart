// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'posting.dart';
import 'newspage.dart';
import 'article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COMMUNITY'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 249, 255, 223),
      ),
      body: Column(
        children: [
          // LATEST NEWS SECTION
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 35.0, right: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 247, 211),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  'LATEST NEWS',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color.fromARGB(255, 231, 247, 211),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.newspaper,
                      color: Color.fromARGB(255, 86, 125, 1),
                      size: 35.0,
                    ),
                    Text(
                      'Updated Farming News',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'receive real-time updates on farming news',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(), // Adds space between the text and the IconButton
                IconButton(
                  icon: Icon(Icons.arrow_circle_right),
                  iconSize: 45.0,
                  color: Color.fromARGB(255, 86, 125, 1).withOpacity(0.5),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => newspage()),
                    );
                    // Add the action for the IconButton here
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 28),

          // COMMUNITY POST SECTION
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 35.0, right: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 247, 194),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  'COMMUNITY POST',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color.fromARGB(255, 238, 247, 194),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.comment,
                      color: Color.fromARGB(255, 86, 125, 1),
                      size: 35.0,
                    ),
                    Text(
                      'Community Sharing',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'post experience and learn from other farmers',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(), // Adds space between the text and the IconButton
                IconButton(
                  icon: Icon(Icons.arrow_circle_right),
                  iconSize: 45.0,
                  color: Color.fromARGB(255, 86, 125, 1).withOpacity(0.5),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Posting()),
                    );
                    // Add the action for the IconButton here
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 28),

          // FARMING TIPS SECTION
          Padding(
            padding: EdgeInsets.only(left: 30.0, top: 35.0, right: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 247, 211),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  'FARMING TIPS',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 00),
            color: Color.fromARGB(255, 231, 247, 211),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Icon(
                      Icons.lightbulb,
                      color: Color.fromARGB(255, 86, 125, 1),
                      size: 35.0,
                    ),
                    Text(
                      'Tips and Farming Knowledge',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'access tips and insights of crop management',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(), // Adds space between the text and the IconButton
                IconButton(
                  icon: Icon(Icons.arrow_circle_right),
                  iconSize: 45.0,
                  color: Color.fromARGB(255, 86, 125, 1).withOpacity(0.5),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(),
                        ));
                    // Add the action for the IconButton here
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }
}
