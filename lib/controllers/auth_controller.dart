import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthController {
  // Keys for SharedPreferences
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';

  // Login - Using SharedPreferences (Local Memory)
  Future<bool> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      
      if (usersJson == null) {
        return false; // No users registered
      }
      
      final List<dynamic> users = json.decode(usersJson);
      
      // Find user with matching email and password
      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          // Save current user session
          await prefs.setString(_currentUserKey, json.encode(user));
          return true;
        }
      }
      
      return false; // Invalid credentials
    } catch (e) {
      return false;
    }
  }

  // Sign Up - Using SharedPreferences (Local Memory)
  Future<bool> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      
      List<dynamic> users = [];
      if (usersJson != null) {
        users = json.decode(usersJson);
      }
      
      // Check if email already exists
      for (var user in users) {
        if (user['email'] == email) {
          return false; // Email already registered
        }
      }
      
      // Create new user
      final newUser = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      users.add(newUser);
      
      // Save users list
      await prefs.setString(_usersKey, json.encode(users));
      
      // Save current user session
      await prefs.setString(_currentUserKey, json.encode(newUser));
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Change Password - Using SharedPreferences (Local Memory)
  Future<bool> changePassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      
      if (usersJson == null) {
        return false;
      }
      
      List<dynamic> users = json.decode(usersJson);
      
      // Find and update user password
      bool found = false;
      for (int i = 0; i < users.length; i++) {
        if (users[i]['email'] == email) {
          users[i]['password'] = newPassword;
          found = true;
          break;
        }
      }
      
      if (!found) {
        return false;
      }
      
      // Save updated users list
      await prefs.setString(_usersKey, json.encode(users));
      
      // Update current user session if it's the same user
      final currentUserJson = prefs.getString(_currentUserKey);
      if (currentUserJson != null) {
        final currentUser = json.decode(currentUserJson);
        if (currentUser['email'] == email) {
          currentUser['password'] = newPassword;
          await prefs.setString(_currentUserKey, json.encode(currentUser));
        }
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Forgot Password - Check if email exists
  Future<bool> checkEmailExists(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString(_usersKey);
      
      if (usersJson == null) {
        return false;
      }
      
      final List<dynamic> users = json.decode(usersJson);
      
      for (var user in users) {
        if (user['email'] == email) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
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
