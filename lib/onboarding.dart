// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:movieapp/screens/login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Find Your Next Favorite Movie Here",
      "description":
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "button": "Explore Now",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Discover Movies",
      "description":
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      "button": "Next",
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Explore All Genres",
      "description":
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day..",
      "button": "Next",
    },
    {
      "image": "assets/images/onboarding4.png",
      "title": "Create Watchlists",
      "description":
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      "button": "Next",
    },
    {
      "image": "assets/images/onboarding5.png",
      "title": "Rate, Review, and Learn",
      "description":
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
      "button": "Next",
    },
    {
      "image": "assets/images/onboarding6.png",
      "title": "Get Started",
      "description": "",
      "button": "Finish",
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background PageView with fullscreen images
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onboardingData[index]["image"]!),
                    fit: BoxFit.contain,
                    alignment: const Alignment(0, -0.8),
                  ),
                ),
                child: Container(
                  decoration: index == 2
                      ? const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff85210E),
                        Colors.transparent,
                        Color(0xff85210E),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  )
                      : BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              );
            },
          ),

          /// First screen (no bottom sheet)
          if (_currentPage == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      onboardingData[0]["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      onboardingData[0]["description"]!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF6BD00),
                        foregroundColor: const Color(0xff121312),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: _nextPage,
                      child: Text(onboardingData[0]["button"]!),
                    ),
                  ],
                ),
              ),
            ),

          /// Bottom Sheet overlay (rest of screens)
          if (_currentPage != 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff121312),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                child: SizedBox(
                  height: _currentPage == onboardingData.length - 1 || _currentPage == 1
                      ? MediaQuery.of(context).size.height * 0.3 // smaller for last
                      : MediaQuery.of(context).size.height * 0.37,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Title
                        Text(
                          onboardingData[_currentPage]["title"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),

                        /// Description
                        Text(
                          onboardingData[_currentPage]["description"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        /// Buttons
                        if (_currentPage == 2 ||
                            _currentPage == 3 ||
                            _currentPage == 4)
                          Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffF6BD00),
                                  foregroundColor: const Color(0xff121312),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: _nextPage,
                                child: const Text("Next"),
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xffF6BD00),
                                  side: const BorderSide(
                                      color: Color(0xffF6BD00), width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: _previousPage,
                                child: const Text("Back"),
                              ),
                            ],
                          )
                        else if (_currentPage == 1)
                        /// Second screen: only Next
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF6BD00),
                              foregroundColor: const Color(0xff121312),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: _nextPage,
                            child: Text(onboardingData[1]["button"]!),
                          )
                        else if (_currentPage == onboardingData.length - 1)
                          /// Last screen: Finish above Back
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffF6BD00),
                                    foregroundColor: const Color(0xff121312),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                  onPressed: _nextPage,
                                  child: const Text("Finish"),
                                ),
                                const SizedBox(height: 12),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xffF6BD00),
                                    side: const BorderSide(
                                        color: Color(0xffF6BD00), width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                  onPressed: _previousPage,
                                  child: const Text("Back"),
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xffF6BD00),
                                      side: const BorderSide(
                                          color: Color(0xffF6BD00), width: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    onPressed: _previousPage,
                                    child: const Text("Back"),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffF6BD00),
                                      foregroundColor: const Color(0xff121312),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    onPressed: _nextPage,
                                    child: Text(
                                      onboardingData[_currentPage]["button"]!,
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
