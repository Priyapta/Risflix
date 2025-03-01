import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/pages/detailPage.dart';

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
                              builder: (context) => detailMoviePage(
                                    title: movie.title,
                                    path:
                                        "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                                  )),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                          fit: BoxFit.cover,
                          width: 150,
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.title.length > 20
                          ? "${movie.title.substring(0, 17)}..."
                          : movie.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          "${movie.date.substring(0, 4)} | ",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.deepPurple,
                        ),
                        Text(
                          " ${movie.voteAverage.toStringAsFixed(1)}",
                          style: const TextStyle(color: Colors.white),
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
