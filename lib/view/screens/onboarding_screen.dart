import 'package:flutter/material.dart';
import 'package:ghar_for_sale/model/onboarding_model.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/bottom_navigation_screen.dart';
import 'package:ghar_for_sale/view/screens/login_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: "Buy Property",
      subtitle: "Find your dream home from trusted builders.",
      image: "assets/images/buy.jpg",
    ),
    OnboardingModel(
      title: "Rent Easily",
      subtitle: "Rent homes with zero hassle & full transparency.",
      image: "assets/images/rent.jpg",
    ),
    OnboardingModel(
      title: "Explore Nearby",
      subtitle: "Discover properties near your location.",
      image: "assets/images/explore.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (context, index) {
                return OnboardingPage(data: pages[index]);
              },
            ),
          ),

          /// DOT INDICATORS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(4),
                height: 8,
                width: currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onTapped: () {
                  if (currentIndex == pages.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                text: currentIndex == pages.length - 1 ? "Get Started" : "Next",
                color: blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
