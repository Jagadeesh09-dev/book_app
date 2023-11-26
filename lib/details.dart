import 'package:bookbin/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(selectedBook.title!,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        // margin: EdgeInsets.all(20.0),
        child: const PDF().cachedFromUrl(
          selectedBook.pdf!,
          placeholder: (progress) => Center(
              child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'assets/images/loader.gif',
                color: Colors.yellow,
              ),
              Text(
                '${progress.toInt()}%',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}
