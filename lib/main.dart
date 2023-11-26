import 'package:bookbin/home.dart';
import 'package:bookbin/splash_screen.dart';
import 'package:bookbin/utils.dart';
import 'package:flutter/material.dart';

import 'details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Color(0xff02537e),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff02537e)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (BuildContext context) => const HomePage(),
          '/details': (BuildContext context) => const DetailsPage(),
        });
  }
}
