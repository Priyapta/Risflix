import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/movie_detail.dart';
import 'package:movie_app/services/service.dart';
import 'package:movie_app/widgets/recommendation.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({super.key, required this.id});

  final int id;

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  late Future<List<MovieDetailModel>?> movieDetail;
  late Future<List<MovieModel>?> recommendMovie;

  @override
  void initState() {
    super.initState();
    recommendMovie = APIservices().getRecommend(widget.id);
    movieDetail = APIservices()
        .getDetail(widget.id)
        .then((detail) => detail != null ? [detail] : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: FutureBuilder<List<MovieDetailModel>?>(
        future: movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Failed to load movie details"));
          }

          final movie = snapshot.data![0];

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 450,
                    ),
                    Positioned(
                      top: 430,
                      left: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            height: 20,
                            color: const Color.fromARGB(255, 24, 24, 24)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTag(
                              movie.releaseDate.toString().substring(0, 4)),
                          const SizedBox(width: 5),
                          _buildTag(movie.genres.first.name),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildIMDBRating(movie.voteAverage),
                      const SizedBox(height: 8),
                      Text(
                        movie.overview,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendations(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIMDBRating(double rating) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        "IMDB ${rating.toStringAsFixed(1)}",
        style: const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return FutureBuilder<List<MovieModel>?>(
      future: recommendMovie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(
              child: Text("No recommendations available",
                  style: TextStyle(color: Colors.white)));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Recommendations",
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            recommendationMovie(movies: recommendMovie),
          ],
        );
      },
    );
  }
}
