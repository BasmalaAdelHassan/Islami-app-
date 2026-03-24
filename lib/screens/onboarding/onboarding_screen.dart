import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'onboarding_model.dart';
import '../../screens/home_layout/home_layout_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      imagePath: "assets/images/Group.png",
      title: "Welcome To Islmi App",
      description: "",
    ),
    OnboardingModel(
      imagePath: "assets/images/kabba.png",
      title: "Welcome To Islami",
      description: "We Are Very Excited To Have You In Our Community",
    ),
    OnboardingModel(
      imagePath: "assets/images/welcome.png",
      title: "Reading the Quran",
      description: "Read, and your Lord is the Most Generous",
    ),
    OnboardingModel(
      imagePath: "assets/images/bearish.png",
      title: "Bearish",
      description: "Praise the name of your Lord, the Most High",
    ),
    OnboardingModel(
      imagePath: "assets/images/radio.png",
      title: "Holy Quran Radio",
      description: "You can listen to the Holy Quran Radio through the application for free and easily",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/Mosque-01.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/Islami.png',
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        data.imagePath,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        data.title,
                        style: const TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          data.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: currentIndex > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      onboardingData.length,
                          (index) => buildDot(index),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentIndex == onboardingData.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeLayoutScreen(),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      currentIndex == onboardingData.length - 1 ? "Finish" : "Next",
                      style: const TextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? AppColors.primaryGold
            : AppColors.primaryGold.withValues(alpha: 0.4),
      ),
    );
  }
}