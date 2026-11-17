import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiBaseUrl = 'http://localhost/jetly_backend'; 

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/login.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs == null) {
            print('Error: SharedPreferences not initialized');
            return 'Error: SharedPreferences not initialized';
          }
          prefs.setString('email', email); 
          print('Email saved: $email'); 
          return 'Login successful';
        } else {
          return 'Invalid credentials';
        }
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> updatePassword(String email, String oldPassword, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/update_password.php'), 
        body: {
          'email': email,
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        if (response.body == 'success') {
          return 'Password updated successfully';
        } else {
          return 'Failed to update password';
        }
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }

  Future<String?> getLoggedInUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<Map<String, dynamic>> fetchUserProfile(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/get_user_profile.php'), 
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}
