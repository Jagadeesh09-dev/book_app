import 'dart:convert';
import 'dart:math';

import 'package:bookbin/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'book_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      fetchBooks();
    });
  }

  fetchBooks() async {
    await http.get(Uri.parse('https://api.itbook.store/1.0/new')).then((response) {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for (var book in jsonDecode(response.body)['books']) {
          book['author'] = authors[Random().nextInt(authors.length)];
          book['pdf'] = pdfs[Random().nextInt(pdfs.length)];
          books.add(Book.fromJson(book));
        }
        // return books;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load books');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/book.png',
              width: screenWidth * 0.4,
              // height: screenHeight * 0.2,
            ),
            Text(
              "BOOKBIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.15, letterSpacing: 1.0),
            ),
            FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Image.asset(
                      'assets/images/loader.gif',
                      color: Colors.orangeAccent,
                    );
                  } else {
                    return Container();
                  }
                })
          ],
        ));
  }
}
