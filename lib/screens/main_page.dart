import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_project/screens/leaderboard_page.dart';
import 'package:quiz_project/screens/user_page.dart';
import '../theme/colors.dart';
import 'admin/add_quiz_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   final List<Widget> _pages= [
      HomePage(),
      LeaderboardPage(), 
      UserPage() 
    ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex], 
      bottomNavigationBar: DotNavigationBar(
        currentIndex: currentIndex,
        dotIndicatorColor: Colors.white,
        enablePaddingAnimation: false,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        unselectedItemColor: Colors.grey[300],
        splashBorderRadius: 50,
        backgroundColor: AppColor.introBk2,
        enableFloatingNavBar: false,
        items: [
          DotNavigationBarItem(
              icon: const Icon(Icons.home), selectedColor:AppColor.introBk),
          DotNavigationBarItem(
              icon: const Icon(Icons.leaderboard), selectedColor:AppColor.introBk),
          DotNavigationBarItem(
              icon: const Icon(Icons.person), selectedColor: AppColor.introBk),
        ],
        onTap: (index) {
          if (index < _pages.length) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
