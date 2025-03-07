import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/pages/searchPage.dart';
import 'package:movie_app/services/service.dart';
import 'package:movie_app/widgets/bottomNav.dart';
import 'package:movie_app/widgets/carrousel.dart';
import 'package:movie_app/widgets/listview_movie.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

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
          color: Colors.grey,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text("M E N U"),
                ),
              ),
              ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "RisFlix",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom: 70), // Tambahkan padding agar tidak tertimpa navbar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
                    child: Text(
                      "Now Showing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  FutureBuilder<List<MovieModel>?>(
                    future: nowShowing,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No movies available'));
                      } else {
                        return CarrouselWidgets(
                          nowShowing: nowShowing,
                          status: true,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
                    child: Text(
                      "Popular Movie",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  MovieListWidget(movies: popular),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
                    child: Text(
                      "Top Rated Movie",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  MovieListWidget(movies: topRated),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
