import 'package:flutter/material.dart';
import 'package:movie_app/pages/homePage.dart';
import 'package:movie_app/pages/searchPage.dart';
import 'package:movie_app/widgets/bottomNav.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> page = [
    const Homepage(),
    const SearchMovieScreen(),
    const Center(
        child: Text("Profile Page", style: TextStyle(color: Colors.white))),
  ];

  void _onTabChange(int index) {
    if (selectedIndex == index) return;
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: page[selectedIndex]),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: BottomNavBar(
              selectedIndex: selectedIndex,
              onTabChange: _onTabChange,
            ),
          ),
        ],
      ),
    );
  }
}
