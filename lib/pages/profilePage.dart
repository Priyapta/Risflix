import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Apta",
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   "@priapta",
                  //   style: TextStyle(
                  //       color: Colors.deepPurpleAccent,
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500),
                  // )
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  width: 500,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dashBoardName(
                                title: "Full Name", icon: Icons.person_2),
                            Text("Priyapta Naufal Sudrajat",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 20,
                            ),
                            dashBoardName(
                                title: "Birth Date",
                                icon: Icons.date_range_outlined),
                            Text("1 Mei 2005",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 20,
                            ),
                            dashBoardName(
                                title: "Hobby", icon: Icons.access_time_filled),
                            Text("Watch Anime",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                dashBoardName(
                                    title: "Instagram",
                                    icon: FontAwesomeIcons.instagram),
                              ],
                            ),
                            Text("@priapta",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600))
                          ],
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}

class dashBoardName extends StatelessWidget {
  const dashBoardName({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon),
      SizedBox(
        width: 3,
      ),
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
