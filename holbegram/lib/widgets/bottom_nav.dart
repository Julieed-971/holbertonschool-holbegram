import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/pages/feed.dart';
import 'package:holbegram/screens/pages/add_image.dart';
import 'package:holbegram/screens/pages/favorite.dart';
import 'package:holbegram/screens/pages/profile_screen.dart';
import 'package:holbegram/screens/pages/search.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

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

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
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
        onItemSelected: _onPageChanged,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text(
              "Search",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.add),
            title: Text(
              "Add",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite_outline),
            title: Text(
              "Likes",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Color.fromARGB(255, 0, 0, 0),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person_outline),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Color.fromARGB(218, 226, 37, 24),
            textAlign: TextAlign.center,
            inactiveColor: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
