import 'package:flutter/material.dart';
import 'package:news_api/presentations/homepage.dart';
import 'package:news_api/presentations/profile.dart';
import 'package:news_api/presentations/search.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
