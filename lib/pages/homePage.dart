import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/services/service.dart';
import 'package:movie_app/widgets/carrousel.dart';
import 'package:movie_app/widgets/listview_movie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<MovieModel>?> nowShowing;
  late Future<List<MovieModel>?> popular;
  late Future<List<MovieModel>?> topRated;
  @override
  void initState() {
    nowShowing = APIservices().getShowing();
    popular = APIservices().getPopular();
    topRated = APIservices().getTopRated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Text("M E N U"),
                  ),
                ),
                ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )),
      ),
      appBar: AppBar(
        title: Text(
          "RisFlix",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          Icon(Icons.notifications),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
              child: Text(
                "Now Showing",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                    fontSize: 20),
              ),
            ),
            FutureBuilder<List<MovieModel>?>(
              future: nowShowing,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No movies available'));
                } else {
                  return CarrouselWidgets(
                    nowShowing: nowShowing,
                    status: true,
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
              child: Text(
                "Popular Movie",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                    fontSize: 20),
              ),
            ),
            MovieListWidget(movies: popular),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
              child: Text(
                "Top Rated Movie",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                    fontSize: 20),
              ),
            ),
            MovieListWidget(movies: topRated),
          ],
        ),
      ),
    );
  }
}
