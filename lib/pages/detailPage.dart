import 'package:flutter/material.dart';

class detailMoviePage extends StatefulWidget {
  const detailMoviePage({super.key, required this.path, required this.title});
  final String path;
  final String title;

  @override
  State<detailMoviePage> createState() => _detailMoviePageState();
}

class _detailMoviePageState extends State<detailMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 450,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(widget.path),
                    fit: BoxFit.cover,
                    width: double.infinity, // Lebar gambar mengikuti layar
                    height: 800,
                  ),
                  Positioned(
                    bottom: 15,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          // color: Colors.white,
                          width: 80,
                          height: 30,
                          child: Row(
                            children: [
                              Text(
                                "Play",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
