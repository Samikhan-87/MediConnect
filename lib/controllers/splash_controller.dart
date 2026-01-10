import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediconnect/routes/app_router.dart';
import 'package:flutter/material.dart';

class SplashController {
  Future<void> checkOnboardingStatus(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    final prefs = await SharedPreferences.getInstance();
    
    // Check if user is already logged in
    final currentUser = prefs.getString('current_user');
    if (currentUser != null) {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
      return;
    }
    
    // Check onboarding status
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    if (!context.mounted) return;

    if (hasSeenOnboarding) {
      Navigator.of(context).pushReplacementNamed(AppRouter.login);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
    }
  }
}
