import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF064564),
              Color(0xFF006DA4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Expanded(
                      child: Text(
                        'About Us',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // App Logo
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.medical_services,
                              size: 80,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // App Name
                      const Text(
                        'MediConnect',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // About Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Our Story',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'MediConnect is a revolutionary healthcare application designed to bridge the gap between patients and healthcare providers. This app was created with a vision to make healthcare accessible, convenient, and efficient for everyone.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF666666),
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'The Creators',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildCreatorCard(
                              name: 'Sami Khan',
                              role: 'Lead Developer',
                              icon: Icons.code,
                            ),
                            const SizedBox(height: 12),
                            _buildCreatorCard(
                              name: 'Ahmed Zahid',
                              role: 'Co-Developer',
                              icon: Icons.developer_mode,
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Both Sami Khan and Ahmed Zahid worked tirelessly to bring this masterpiece to life. Their dedication, countless hours of coding, and passion for creating something meaningful resulted in MediConnect - an app that aims to transform how people access healthcare services.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF666666),
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Our Mission',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'To provide a seamless and user-friendly platform that connects patients with qualified healthcare professionals, making booking appointments easier than ever before. We believe everyone deserves access to quality healthcare at their fingertips.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF666666),
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Features
                            const Text(
                              'Key Features',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildFeatureItem('Easy Doctor Search & Booking'),
                            _buildFeatureItem('Appointment Management'),
                            _buildFeatureItem('Secure User Profiles'),
                            _buildFeatureItem('Medical Center Directory'),
                            _buildFeatureItem('Real-time Notifications'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Footer
                      Text(
                        '© 2026 MediConnect. All rights reserved.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorCard({
    required String name,
    required String role,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF006DA4).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF006DA4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                role,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF003366).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF006DA4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xFF006DA4),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
