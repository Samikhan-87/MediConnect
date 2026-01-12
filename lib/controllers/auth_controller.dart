import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Keys for SharedPreferences (for storing current user session)
  static const String _currentUserKey = 'current_user';

  // Login - Using Firebase Authentication
  // Returns null on success, error message on failure
  Future<String?> login(String email, String password) async {
    try {
      // Sign in with Firebase Auth
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        // Get user data from Firestore
        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          // Save current user session to SharedPreferences for quick access
          final currentUser = {
            'uid': userCredential.user!.uid,
            'name': userData['name'],
            'email': userData['email'],
            'phone': userData['phone'],
          };
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_currentUserKey, json.encode(currentUser));
        }
        return null; // Success
      }
      return 'Login failed. Please try again.';
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      return _getErrorMessage(e.code);
    } catch (e) {
      print('Login error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign Up - Using Firebase Authentication
  // Returns null on success, error message on failure
  Future<String?> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Create user with Firebase Auth
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (userCredential.user != null) {
        // Save additional user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': name,
          'email': email.trim(),
          'phone': phone.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Save current user session to SharedPreferences
        final currentUser = {
          'uid': userCredential.user!.uid,
          'name': name,
          'email': email.trim(),
          'phone': phone.trim(),
        };
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_currentUserKey, json.encode(currentUser));

        return null; // Success
      }
      return 'Sign up failed. Please try again.';
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      return _getErrorMessage(e.code);
    } catch (e) {
      print('Sign up error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  // Helper method to get user-friendly error messages
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found with this email. Please sign up first.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email. Please use a different email or sign in.';
      case 'weak-password':
        return 'Password is too weak. Please use a stronger password.';
      case 'invalid-email':
        return 'Invalid email address. Please enter a valid email.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password authentication is not enabled. Please contact support.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  // Change Password - Using Firebase Authentication
  Future<bool> changePassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return false;
      }

      // Update password in Firebase Auth
      await user.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      print('Change password error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('Change password error: $e');
      return false;
    }
  }

  // Forgot Password - Send password reset email using Firebase
  Future<bool> checkEmailExists(String email) async {
    try {
      // Firebase doesn't directly allow checking if email exists for security
      // Instead, we'll try to send a password reset email
      // If email doesn't exist, Firebase will handle it gracefully
      await _auth.sendPasswordResetEmail(email: email.trim());
      return true; // Email sent successfully (or email doesn't exist, but we don't reveal that)
    } on FirebaseAuthException catch (e) {
      // If email doesn't exist, Firebase will throw an exception
      // For security reasons, we return true anyway to not reveal if email exists
      print('Password reset error: ${e.code} - ${e.message}');
      return true; // Return true to not reveal if email exists
    } catch (e) {
      print('Password reset error: $e');
      return false;
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      print('Password reset error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('Password reset error: $e');
      return false;
    }
  }

  // Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentUserJson = prefs.getString(_currentUserKey);
      
      if (currentUserJson == null) {
        return null;
      }
      
      return json.decode(currentUserJson);
    } catch (e) {
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();
      // Clear local session
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_currentUserKey);
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // Get current Firebase user
  User? getCurrentFirebaseUser() {
    return _auth.currentUser;
  }

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
