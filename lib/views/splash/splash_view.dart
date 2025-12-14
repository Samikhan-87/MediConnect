import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mediconnect/controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  final SplashController _controller = SplashController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startAnimationSequence();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // Start from bottom (off-screen)
      end: Offset.zero, // End at center
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
  }

  void _startAnimationSequence() async {
    // Wait 1 second before showing logo (user requested 1-2 seconds)
    await Future.delayed(const Duration(milliseconds: 1000));
    
    if (!mounted) return;
    
    setState(() {
      _showLogo = true;
    });
    
    // Start the animation
    _animationController.forward();
    
    // Wait for animation to complete (800ms) + a bit more, then navigate
    await Future.delayed(const Duration(milliseconds: 1200));
    
    if (!mounted) return;
    _controller.checkOnboardingStatus(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Dark blue background as shown in the design
        color: const Color(0xFF1A3A5C), // Dark teal/blue color
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              if (!_showLogo) {
                // Show nothing initially
                return const SizedBox.shrink();
              }
              
              return SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Image
                      Image.asset(
                        'assets/images/logo.png',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if image fails to load
                          return const Icon(
                            Icons.medical_services,
                            size: 100,
                            color: Colors.white,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
