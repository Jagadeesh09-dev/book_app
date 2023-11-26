import 'dart:convert';
import 'dart:math';

import 'package:bookbin/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> _books = [];
  final _searchController = TextEditingController();
  bool searched = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _books.addAll(books);
    setState(() {});
  }

  searchBooks(String searchText) async {
    setState(() {
      _isLoading = true;
    });
    await http.get(Uri.parse('https://api.itbook.store/1.0/search/{$searchText}')).then((response) {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        _books.clear();
        for (var book in jsonDecode(response.body)['books']) {
          book['author'] = authors[Random().nextInt(authors.length)];
          book['pdf'] = pdfs[Random().nextInt(pdfs.length)];
          _books.add(Book.fromJson(book));
        }
        setState(() {});
        // return books;
        // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load books');
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _isLoading
        ? Container(
            color: Colors.transparent,
            width: 300.0,
            height: 300.0,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/loader.gif',
                  color: Colors.yellow,
                )),
          )
        : Container();
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
                body: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Container(
                        // margin: const EdgeInsets.symmetric(vertical: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(color: Colors.yellow),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Search by title, author or keywords",
                                  hintStyle: GoogleFonts.nunito(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_searchController.text.length > 2) {
                                  FocusScope.of(context).unfocus();
                                  if (!searched) {
                                    searchBooks(_searchController.text);
                                  } else {
                                    _searchController.clear();
                                    _books.clear();
                                    setState(() {
                                      _books.addAll(books);
                                    });
                                  }
                                  setState(() {
                                    searched = !searched;
                                  });
                                }
                              },
                              icon: Icon(
                                searched ? Icons.cancel : Icons.search_outlined,
                                color: Colors.yellow,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Popular Search',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: 40.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                          onTap: () {
                            if (_searchController.text != categories[index]['name']) {
                              _searchController.text = categories[index]['name'];
                              searched = true;
                              setState(() {});
                              searchBooks(_searchController.text);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: _searchController.text == categories[index]['name'] ? Border.all(color: Colors.black) : null,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              categories[index]['name'],
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    !searched
                        ? Text(
                            "Recently Added",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    _books.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _books.length,
                            itemBuilder: (context, bookIndex) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectedBook = _books[bookIndex];
                                      Navigator.pushNamed(context, '/details');
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white12,
                                              border: Border.all(color: Colors.yellow),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Image.network(
                                              _books[bookIndex].imageUrl!,
                                              height: screenHeight * 0.2,
                                              width: screenWidth * 0.3,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.55,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _books[bookIndex].title!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                _books[bookIndex].author!,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.yellow[600],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                _books[bookIndex].subtitle! != "" ? _books[bookIndex].subtitle! : _books[bookIndex].title!,
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.black45,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  )
                                ],
                              );
                            })
                        : Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 100.0,
                                ),
                                Image.asset(
                                  'assets/images/not-found.png',
                                  color: Colors.yellow[600],
                                  height: 80.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "No Books Found",
                                  style: GoogleFonts.nunito(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            )),
            if (_isLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (_isLoading)
              Center(
                child: loadingIndicator,
              ),
          ],
        ),
      ),
    );
  }
}
