import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/pages/homePage.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10), // Padding agar tidak mentok layar
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(0.7), // Warna background dengan opacity
          borderRadius: BorderRadius.circular(30), // Efek rounded untuk navbar
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // Bayangan agar terlihat melayang
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GNav(
          backgroundColor:
              Colors.transparent, // Transparan agar sesuai container
          color: Colors.grey[800], // Warna ikon default
          activeColor: Colors.deepPurple, // Warna ikon aktif
          tabBackgroundColor:
              Colors.deepPurple.withOpacity(0.2), // Background tombol aktif
          gap: 8,
          padding: const EdgeInsets.all(12), // Padding antar icon
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
            ),
            GButton(
              icon: Icons.search,
              text: "Search",
            ),
            GButton(
              icon: Icons.person_2,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
