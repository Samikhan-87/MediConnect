import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediconnect/routes/app_router.dart';

class OnboardingController {
  Future<void> completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (!context.mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRouter.login);
  }
}
