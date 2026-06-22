import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/pages/feed.dart';
import 'package:holbegram/screens/pages/add_image.dart';
import 'package:holbegram/screens/pages/favorite.dart';
import 'package:holbegram/screens/pages/profile_screen.dart';
import 'package:holbegram/screens/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // This function handles CLICKS on the Bottom Bar
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    // CRITICAL FIX: Animate the PageView to the selected index
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // This handles SWIPES on the PageView
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: const [
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: _onPageChanged, // Calls the function we fixed above
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black, // Changed from transparent for visibility
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: const Text(
              "Add",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite_outline),
            title: const Text(
              "Likes",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text(
              "Profile",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: const Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}