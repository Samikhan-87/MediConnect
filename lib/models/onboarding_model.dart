class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> getOnboardingData() {
    return [
      OnboardingModel(
        title: 'Healthcare Made Simple',
        description: 'Book appointments with trusted doctors in minutes — anytime, anywhere, without long calls or waiting lines.',
        imagePath: 'assets/images/onboarding_1_img.png',
      ),
      OnboardingModel(
        title: 'Your Health, Organized',
        description: 'Manage reports, track past visits, and stay updated with reminders — giving you complete control of your health journey.',
        imagePath: 'assets/images/onboarding_2_img.png',
      ),
      OnboardingModel(
        title: 'Connect With Care',
        description: 'Check all your appointments, track past visits, — giving you complete control of your health journey.',
        imagePath: 'assets/images/onboarding_3_img.png',
      ),
    ];
  }
}
