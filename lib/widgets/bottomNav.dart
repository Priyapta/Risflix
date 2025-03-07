import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GNav(
          color: Colors.grey[800],
          activeColor: Colors.deepPurple,
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabBackgroundColor: Colors.deepPurple.withOpacity(0.2),
          gap: 8,
          padding: const EdgeInsets.all(12),
          tabs: const [
            GButton(icon: Icons.home, text: "Home"),
            GButton(icon: Icons.search, text: "Search"),
            GButton(icon: Icons.person, text: "Profile"),
          ],
        ),
      ),
    );
  }
}
