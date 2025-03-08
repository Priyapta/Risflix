import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/pages/detailPage.dart';
import 'package:movie_app/pages/homePage.dart';
import 'package:movie_app/services/service.dart';
import 'package:movie_app/widgets/bottomNav.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({
    super.key,
  });
  @override
  _SearchMovieScreenState createState() => _SearchMovieScreenState();
}

Future<List<MovieModel>> _searchMovies(
    String query, List<MovieModel> movie) async {
  return await APIservices().searchMovies(query, movie);
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio dio = Dio();
  List<MovieModel> movies = [];
  late Future<List<MovieModel>> movie;
  @override
  void initState() {
    super.initState();
    movie = APIservices().searchMovies("", []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Movies"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              // Search Box
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search movies...",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                movies = [];
                              });
                            },
                          )
                        : null,
                  ),
                  onSubmitted: (query) {
                    setState(() {
                      movie = _searchMovies(query, []);
                    });
                  },
                ),
              ),

              // Loading Indicator

              // Movie List
              Expanded(
                child: FutureBuilder<List<MovieModel>>(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.white)));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No movies found',
                              style: TextStyle(color: Colors.white)));
                    } else {
                      final movies = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          final imageUrl = movie.posterPath != null
                              ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                              : "https://picsum.photos/500/750";

                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailMoviePage(id: movie.id)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: ClipRRect(
                                          child: Image.network(imageUrl,
                                              width: 120,
                                              height: 100,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title.length > 35
                                                ? "${movie.title.substring(0, 30)}..."
                                                : movie.title,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 2),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          movie.voteAverage
                                                              .toStringAsFixed(
                                                                  1),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 2),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .person_4_rounded,
                                                          size: 15,
                                                        ),
                                                        Text(
                                                          movie.voteCount
                                                              .toString(),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                )),
                          );

                          // return ListTile(
                          //   leading: Image.network(imageUrl,
                          //       width: 50, height: 75, fit: BoxFit.cover),
                          //   title: Text(
                          //     movie.title,
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          //   subtitle: Text(
                          //     "Release Date: ${movie.date ?? "Unknown"}",
                          //     style: TextStyle(color: Colors.grey),
                          //   ),
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 DetailMoviePage(id: movie.id)));
                          //   },
                          // );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
