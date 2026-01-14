import 'package:flutter/material.dart';
import 'package:mediconnect/models/medical_center_model.dart';
import 'package:mediconnect/views/auth/forgot_password_view.dart';
import 'package:mediconnect/views/auth/login_view.dart';
import 'package:mediconnect/views/auth/signup_view.dart';
import 'package:mediconnect/views/home/home_view.dart';
import 'package:mediconnect/views/medical_center/medical_center_details_view.dart';
import 'package:mediconnect/views/notifications/notifications_view.dart';
import 'package:mediconnect/views/doctors/all_doctors_view.dart';
import 'package:mediconnect/views/doctors/doctor_details_view.dart';
import 'package:mediconnect/views/onboarding/onboarding_view.dart';
import 'package:mediconnect/views/splash/splash_view.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String allDoctors = '/doctors';
  static const String medicalCenterDetails = '/medical-center-details';
  static const String doctorDetails = '/doctor-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case allDoctors:
        return MaterialPageRoute(builder: (_) => const AllDoctorsView());
      case medicalCenterDetails:
        final medicalCenter = settings.arguments as MedicalCenterModel;
        return MaterialPageRoute(
          builder: (_) =>
              MedicalCenterDetailsView(medicalCenter: medicalCenter),
        );
      case doctorDetails:
        final doctor = settings.arguments as dynamic;
        return MaterialPageRoute(
            builder: (_) => DoctorDetailsView(doctor: doctor));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
