import 'package:flutter/material.dart';
import 'package:movie_app/pages/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 24, 24, 24),
        appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 24, 24, 24),
            iconTheme: IconThemeData(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.deepPurple),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primaryContainer: Color.fromARGB(255, 24, 24, 24)),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
