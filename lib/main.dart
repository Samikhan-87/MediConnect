import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediconnect/routes/app_router.dart';
import 'package:mediconnect/theme/app_theme.dart';

void main() {
  runApp(const MediConnectApp());
}

class MediConnectApp extends StatelessWidget {
  const MediConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
