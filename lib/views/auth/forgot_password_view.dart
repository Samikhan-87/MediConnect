import 'package:flutter/material.dart';
import 'package:mediconnect/controllers/auth_controller.dart';
import 'package:mediconnect/routes/app_router.dart';
import 'package:mediconnect/widgets/custom_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController _controller = AuthController();
  bool _isLoading = false;
  bool _emailVerified = false;
  bool _passwordChanged = false;
  String? _userEmail;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyEmail() async {
    if (_emailFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final emailExists = await _controller.checkEmailExists(
        _emailController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        if (emailExists) {
          _emailVerified = true;
          _userEmail = _emailController.text.trim();
        }
      });

      if (!emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not found. Please check and try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleChangePassword() async {
    if (_passwordFormKey.currentState!.validate()) {
      if (_userEmail == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not found. Please go back and try again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final success = await _controller.changePassword(
        email: _userEmail!,
        newPassword: _newPasswordController.text,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _passwordChanged = success;
      });

      if (success) {
        _showSuccessModal();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to change password. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SuccessModal(
        onBackToLogin: () {
          Navigator.of(context).pop(); // Close modal
          Navigator.of(context).pushReplacementNamed(AppRouter.login);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366), // Dark blue background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _emailVerified
              ? _buildPasswordChangeForm()
              : _buildEmailVerificationForm(),
        ),
      ),
    );
  }

  Widget _buildEmailVerificationForm() {
    return Form(
      key: _emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          // Title
          const Text(
            'Forget Password',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            'Please enter your email address to reset your password.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Email Field
          CustomTextField(
            label: 'Email',
            hint: 'Enter Your Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _controller.validateEmail,
          ),
          const SizedBox(height: 32),
          // Send Reset Link Button
          ElevatedButton(
            onPressed: _isLoading ? null : _handleVerifyEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF003366),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF003366),
                      ),
                    ),
                  )
                : const Text(
                    'Send Reset Link',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF4A9EFF), // Bright blue
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordChangeForm() {
    return Form(
      key: _passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          // Title
          const Text(
            'Forget Password',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            'Please enter your new password and confirm password here.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // New Password Field
          CustomTextField(
            label: 'New Password',
            hint: 'Enter Your New Password',
            controller: _newPasswordController,
            obscureText: true,
            validator: _controller.validatePassword,
          ),
          const SizedBox(height: 24),
          // Confirm Password Field
          CustomTextField(
            label: 'Confirm Password',
            hint: 'Enter Confirm Password',
            controller: _confirmPasswordController,
            obscureText: true,
            validator: (value) => _controller.validateConfirmPassword(
              value,
              _newPasswordController.text,
            ),
          ),
          const SizedBox(height: 32),
          // Change Password Button
          ElevatedButton(
            onPressed: _isLoading ? null : _handleChangePassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF003366),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF003366),
                      ),
                    ),
                  )
                : const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF4A9EFF), // Bright blue
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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

class _SuccessModal extends StatelessWidget {
  final VoidCallback onBackToLogin;

  const _SuccessModal({required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A4A6B),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            // Logo/Icon
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 24),
            // Title
            const Text(
              'Password Changed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            // Message
            const Text(
              'Congratulations Your Password Has Been Changed Successfully.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Back to Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBackToLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF003366),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Back to Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
