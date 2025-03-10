import 'package:flutter/material.dart';
import 'package:movie_app/pages/mainPage.dart';

class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),

                    // Foto di tengah lingkaran
                    Positioned(
                      child: Container(
                        width: 180, // Ukuran foto
                        height: 200,
                        child: Image.asset("assets/movie_app.png"),
                      ),
                    ),
                  ],
                )),
            Text(
              "Welcome to Risflix",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              "An easy-to-use app for discovering movies, reading reviews, and exploring what to watch next. Find top-rated films and user opinions—all in one place",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
