// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madass/news_webview.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class newspage extends StatefulWidget {
  const newspage({super.key});

  @override
  State<newspage> createState() => _newspageState();
}

class _newspageState extends State<newspage> {
  late Future<List<Article>> future;
  List<Article> farmNews = []; // save the list for seraching within farm news
  String? searchTerm; // ? means variable can be null
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = getNewsData("agriculture");
    future.then((value) {
      setState(() {
        farmNews = value; // Store fetched "farm" news in the farmNews list
      });
    });
  }

  Future<List<Article>> getNewsData(String query) async {
    NewsAPI newsAPI = NewsAPI("e06b19d0f7534e2ba0a961222e4fff83");
    return await newsAPI.getEverything(
      query: query,
      pageSize: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isSearching ? searchAppBar() : appBar(),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading the news"),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<Article> sortedArticles =
                          snapshot.data as List<Article>;
                      sortedArticles.sort(
                          (a, b) => b.publishedAt!.compareTo(a.publishedAt!));
                      return buildNewsListView(snapshot.data as List<Article>);
                    } else {
                      return const Center(
                        child: Text("No news available"),
                      );
                    }
                  }
                },
                future: future,
              ),
            )
          ],
        )));
  }

  searchAppBar() {
    return AppBar(
        backgroundColor: Color.fromARGB(255, 249, 255, 223),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(
                () {
                  if (isSearching) {
                    // If currently searching, revert to displaying all farmNews
                    isSearching = false;
                    searchTerm = null;
                    searchController.text = "";
                    future = Future.value(farmNews);
                  } else {
                    // Navigate back to the home page if not searching
                    Navigator.of(context).pop();
                  }
                },
              );
            }),
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.grey),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchTerm = searchController.text.toLowerCase();
                if (searchTerm!.isNotEmpty) {
                  // Filter farmNews based on the search term
                  List<Article> filteredNews = farmNews
                      .where((article) =>
                          article.title!.toLowerCase().contains(searchTerm!))
                      .toList();

                  // Provide the filtered list as a future for FutureBuilder
                  future = Future.value(filteredNews);
                } else {
                  // If search is empty, display all farmNews
                  future = Future.value(farmNews);
                }
                isSearching = false;
              });
            },
            icon: const Icon(Icons.search),
          )
        ]);
  }

  appBar() {
    return AppBar(
        title: Text('NEWS'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 249, 255, 223),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search),
          )
        ]);
  }
}

Widget buildNewsListView(List<Article> articleList) {
  return ListView.builder(
    itemBuilder: (context, index) {
      Article article = articleList[index];
      return _buildNewsItem(context, article);
    },
    itemCount: articleList.length,
  );
}

Widget _buildNewsItem(BuildContext context, Article article) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Card(
      color: Color.fromARGB(255, 231, 247, 211),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the date on top
            Text(
              article.publishedAt
                  .toString()
                  .substring(0, 10), // Replace with the actual date field
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            // Horizontal picture
            SizedBox(
              height: 150,
              width: 500,
              child: Image.network(
                article.urlToImage ?? "",
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
              ),
            ),
            SizedBox(height: 8),
            // News title
            Text(
              article.title!,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            // Read more button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsWebView(url: article.url!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Color.fromARGB(
                      255, 86, 125, 1), // Set text color to green
                  side: BorderSide(
                      width: 1,
                      color:
                          Color.fromARGB(255, 86, 125, 1)), // Add green border
                  elevation: 0,
                ),
                child: Text("Read More"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
