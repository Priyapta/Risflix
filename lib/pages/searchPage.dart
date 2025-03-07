import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio dio = Dio();
  List<dynamic> movies = [];
  bool _isLoading = false;
  late Future<List?> movie;

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
                  onSubmitted: (query) async {
                    setState(() {
                      _isLoading = true;
                    });

                    movies = await APIservices().searchMovies(query, movies);
                    setState(() {
                      movies = movies;
                      _isLoading = false;
                    });
                  },
                ),
              ),

              // Loading Indicator
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),

              // Movie List
              Expanded(
                child: movies.isEmpty
                    ? Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          final imageUrl = movie["poster_path"] != null
                              ? "https://image.tmdb.org/t/p/w500${movie["poster_path"]}"
                              : "https://picsum.photos/500/750";

                          return ListTile(
                            leading: Image.network(imageUrl,
                                width: 50, height: 75, fit: BoxFit.cover),
                            title: Text(
                              movie["title"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Release Date: ${movie["release_date"] ?? "Unknown"}",
                              style: TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMoviePage(id: movie["id"])));
                            },
                          );
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
