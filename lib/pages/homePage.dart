import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/services/service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<MovieModel>?> nowShowing;
  @override
  void initState() {
    nowShowing = APIservices().getShowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RisFlix"),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          Icon(Icons.notifications),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: nowShowing,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final movies = snapshot.data;
                  return CarouselSlider.builder(
                    itemCount: movies?.length ?? 0,
                    itemBuilder: (context, index, movieIndex) {
                      final movie = movies![index];
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/original/${movie.backdropPath}"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  // Wajib agar efek blur mengikuti border radius
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5, sigmaY: 15), // Efek blur
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey.withOpacity(
                                            0.3), // Semi transparan
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
