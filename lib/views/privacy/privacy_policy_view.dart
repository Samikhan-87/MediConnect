import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
                        'Privacy Policy',
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
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last updated: January 21, 2026',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          'Introduction',
                          'Welcome to MediConnect. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data when you visit our application and tell you about your privacy rights and how the law protects you.',
                        ),
                        _buildSection(
                          'Information We Collect',
                          'We collect information that you provide directly to us, including:\n\n• Personal identification information (name, email address, phone number)\n• Health-related information for appointment booking purposes\n• Profile pictures and preferences\n• Device information and usage data\n• Location data when you use our services',
                        ),
                        _buildSection(
                          'How We Use Your Information',
                          'We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process and complete transactions\n• Send you technical notices, updates, and support messages\n• Respond to your comments, questions, and requests\n• Monitor and analyze trends, usage, and activities\n• Personalize and improve your experience',
                        ),
                        _buildSection(
                          'Data Security',
                          'We implement appropriate technical and organizational measures to protect the security of your personal information. However, please note that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal data, we cannot guarantee its absolute security.',
                        ),
                        _buildSection(
                          'Data Sharing',
                          'We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except:\n\n• To healthcare providers you choose to connect with\n• To comply with legal obligations\n• To protect our rights and safety\n• With service providers who assist in our operations',
                        ),
                        _buildSection(
                          'Your Rights',
                          'You have the right to:\n\n• Access your personal data\n• Correct inaccurate data\n• Request deletion of your data\n• Object to processing of your data\n• Request data portability\n• Withdraw consent at any time',
                        ),
                        _buildSection(
                          'Cookies and Tracking',
                          'We use cookies and similar tracking technologies to track activity on our application and hold certain information. Cookies are files with a small amount of data that are sent to your browser from a website and stored on your device.',
                        ),
                        _buildSection(
                          'Children\'s Privacy',
                          'Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe your child has provided us with personal information, please contact us.',
                        ),
                        _buildSection(
                          'Changes to This Policy',
                          'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date at the top of this Privacy Policy.',
                        ),
                        _buildSection(
                          'Contact Us',
                          'If you have any questions about this Privacy Policy, please contact us at:\n\nEmail: support@mediconnect.com\nPhone: +1 (555) 123-4567\nAddress: 123 Healthcare Avenue, Medical City, MC 12345',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
