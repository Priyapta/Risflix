import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/pages/detailPage.dart';

class CarrouselWidgets extends StatefulWidget {
  const CarrouselWidgets(
      {super.key, required this.nowShowing, required this.status});
  final Future<List<MovieModel>?> nowShowing;
  final bool status;

  @override
  State<CarrouselWidgets> createState() => _CarrouselWidgetsState();
}

class _CarrouselWidgetsState extends State<CarrouselWidgets> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.nowShowing,
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMoviePage(
                                      id: movie.id,
                                    )),
                          );
                        },
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${movie.posterPath}"),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 40,
                        left: 22,
                        right: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "(${movie.date.substring(0, 4)})",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                  ],
                );
              },
              options: CarouselOptions(
                height: 340,
                viewportFraction: 0.8,
                autoPlay: widget.status,
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
