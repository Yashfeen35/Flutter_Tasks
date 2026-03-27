import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  double _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to FitLife',
      'subtitle': 'Your all-in-one fitness companion',
      'image': 'assets/fitness5.jpg',
    },
    {
      'title': 'Track Workouts',
      'subtitle': 'Keep track of your daily exercises and stay motivated',
      'image': 'assets/squatson.png',
    },
    {
      'title': 'Stay Hydrated',
      'subtitle': 'Monitor your daily water intake easily',
      'image': 'assets/fitness2.jpg',
    },
    {
      'title': 'Welcome to healthy routine',
      'subtitle':
          'Discover a smarter way to stay fit, feel great and take control of your health',
      'image': 'assets/biceps.png',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index.toDouble();
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(page['image']!, height: 250),
                        SizedBox(height: 40),
                        Text(
                          page['title']!,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF282165),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF282165),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Next / Get Started Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: _currentPage.toInt() == _pages.length - 1
                  // Last page: show a centered Get Started button (no filled background)
                  ? SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.login);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF282165),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextButton(
                            onPressed: () {
                              Get.offNamed(Routes.login);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF282165),
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Skip',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: _nextPage,
                            style: TextButton.styleFrom(
                              foregroundColor: Color(0xFF282165),
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
