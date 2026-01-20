import 'package:flutter/material.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

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
                        'Terms & Conditions',
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
                          'Terms and Conditions',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003366),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Effective Date: January 21, 2026',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          '1. Agreement to Terms',
                          'By accessing or using MediConnect, you agree to be bound by these Terms and Conditions. If you disagree with any part of these terms, you may not access the application. These Terms apply to all visitors, users, and others who access or use the Service.',
                        ),
                        _buildSection(
                          '2. Description of Service',
                          'MediConnect is a healthcare appointment booking platform that connects patients with healthcare providers. Our services include:\n\n• Doctor search and discovery\n• Appointment booking and management\n• Medical center information\n• User profile management\n• Healthcare provider ratings and reviews',
                        ),
                        _buildSection(
                          '3. User Accounts',
                          'When you create an account with us, you must provide accurate, complete, and current information. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account.\n\nYou are responsible for safeguarding the password and for all activities that occur under your account. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.',
                        ),
                        _buildSection(
                          '4. Appointment Booking',
                          'By using our appointment booking service, you agree that:\n\n• You will provide accurate information when booking\n• You will attend scheduled appointments or cancel in advance\n• You understand that appointment availability is subject to change\n• Booking confirmation does not guarantee service\n• Cancellation policies may apply',
                        ),
                        _buildSection(
                          '5. User Conduct',
                          'You agree not to use the Service to:\n\n• Violate any applicable laws or regulations\n• Impersonate any person or entity\n• Harass, abuse, or harm another person\n• Submit false or misleading information\n• Upload malicious code or interfere with the Service\n• Collect user information without consent\n• Use the Service for unauthorized commercial purposes',
                        ),
                        _buildSection(
                          '6. Medical Disclaimer',
                          'MediConnect is a platform for booking appointments and does not provide medical advice, diagnosis, or treatment. The information provided through our Service is for informational purposes only.\n\nAlways seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. Never disregard professional medical advice or delay in seeking it because of something you have read on this application.',
                        ),
                        _buildSection(
                          '7. Intellectual Property',
                          'The Service and its original content, features, and functionality are and will remain the exclusive property of MediConnect and its licensors. The Service is protected by copyright, trademark, and other laws. Our trademarks may not be used in connection with any product or service without prior written consent.',
                        ),
                        _buildSection(
                          '8. Limitation of Liability',
                          'In no event shall MediConnect, its directors, employees, partners, agents, suppliers, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your access to or use of or inability to access or use the Service.',
                        ),
                        _buildSection(
                          '9. Termination',
                          'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms. Upon termination, your right to use the Service will immediately cease.',
                        ),
                        _buildSection(
                          '10. Changes to Terms',
                          'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will try to provide at least 30 days\' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.',
                        ),
                        _buildSection(
                          '11. Governing Law',
                          'These Terms shall be governed and construed in accordance with the laws, without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights.',
                        ),
                        _buildSection(
                          '12. Contact Information',
                          'If you have any questions about these Terms, please contact us at:\n\nEmail: legal@mediconnect.com\nPhone: +1 (555) 123-4567\nAddress: 123 Healthcare Avenue, Medical City, MC 12345',
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF006DA4).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF006DA4),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'By using MediConnect, you acknowledge that you have read and understood these Terms and Conditions.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF003366),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
