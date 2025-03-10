import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/pages/detailPage.dart';
import 'package:movie_app/services/service.dart';

class MovieListWidget extends StatelessWidget {
  final Future<List<MovieModel>?> movies;

  const MovieListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>?>(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No movies available'));
        } else {
          return Container(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMoviePage(id: movie.id),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                            fit: BoxFit.cover,
                            width: 160,
                            height: 220,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title.length > 20
                          ? "${movie.title.substring(0, 17)}..."
                          : movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "${movie.date.substring(0, 4)} | ",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        Text(
                          " ${movie.voteAverage.toStringAsFixed(1)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
