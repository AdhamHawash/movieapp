import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/screens/home/home_tab.dart';
import 'package:movieapp/screens/home/profile_tap.dart';
import 'package:movieapp/screens/home/search_tap.dart';
import '../home/explore_tap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const SearchTab(),
    const ExploreTab(),
    const ProfileTab(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': 'assets/icons/home.png',
      'label': '',
    },
    {
      'icon': 'assets/icons/search.png',
      'label': '',
    },
    {
      'icon': 'assets/icons/explore.png',
      'label': '',
    },
    {
      'icon': 'assets/icons/profile.png',
      'label': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabs[_currentIndex],

          // Custom Bottom Navigation Bar
          Positioned(
            left: 5,
            right: 5,
            bottom: 5,
            child: Container(
              height: kBottomNavigationBarHeight,
              decoration: BoxDecoration(
                color: const Color(0xff282A28),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  final item = _navItems[index];
                  final isActive = _currentIndex == index;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['icon'],
                              width: 24.w,
                              height: 24.h,
                              color: isActive ? const Color(0xffF6BD00) : Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}