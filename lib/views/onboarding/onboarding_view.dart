import 'package:flutter/material.dart';
import 'package:mediconnect/controllers/onboarding_controller.dart';
import 'package:mediconnect/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnboardingController _controller = OnboardingController();
  final List<OnboardingModel> _onboardingData = OnboardingModel.getOnboardingData();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return _OnboardingPage(data: _onboardingData[index]);
            },
          ),
          // Bottom Panel with Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: _BottomContentPanel(
                currentPage: _currentPage,
                totalPages: _onboardingData.length,
                data: _onboardingData[_currentPage],
                pageController: _pageController,
                onSkip: () => _controller.completeOnboarding(context),
                onNext: () {
                  if (_currentPage == _onboardingData.length - 1) {
                    _controller.completeOnboarding(context);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingModel data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        data.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 100),
            ),
          );
        },
      ),
    );
  }
}

class _BottomContentPanel extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final OnboardingModel data;
  final PageController pageController;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  const _BottomContentPanel({
    required this.currentPage,
    required this.totalPages,
    required this.data,
    required this.pageController,
    required this.onSkip,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A3A5C), // Dark teal-blue color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Slider/Page Indicator
          SmoothPageIndicator(
            controller: pageController,
            count: totalPages,
            effect: const ScrollingDotsEffect(
              activeDotColor: Colors.white,
              dotColor: Color(0xFF4A6B8A),
              dotHeight: 6,
              dotWidth: 32,
              spacing: 8,
              radius: 3,
            ),
          ),
          const SizedBox(height: 32),
          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip Button
              if (currentPage < totalPages - 1)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: ElevatedButton(
                      onPressed: onSkip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1A3A5C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              // Next/Get Started Button
              Expanded(
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A3A5C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentPage == totalPages - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
