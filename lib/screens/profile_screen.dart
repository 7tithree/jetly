import 'package:flutter/material.dart';
import 'package:jetly_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  String _email = '';
  String _name = '';
  String _phone = '';
  String _address = ''; 
  String _password = ''; // Password is fetched but not displayed
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService(); 

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      print('Retrieved email: $email');
      
      if (email != null) {
        var userProfile = await _authService.fetchUserProfile(email); 
        setState(() {
          _email = userProfile['email'] ?? 'Not available';
          _name = userProfile['name'] ?? 'Not available';
          _phone = userProfile['phone'] ?? 'Not available';
          _address = userProfile['address'] ?? 'Not available';
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to load profile: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePassword() async {
    String newPassword = _passwordController.text.trim();
    if (newPassword.isEmpty) {
      _showErrorDialog("Password cannot be empty");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String updateResult = await _authService.updatePassword(_email, newPassword, 'extraArgument');
      if (updateResult == 'success') { 
        _showSuccessDialog("Password updated successfully!");
      } else {
        _showErrorDialog("Failed to update password");
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email'); 

    Navigator.pushReplacementNamed(context, '/login'); 
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Profile")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: $_name', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          Text('Email: $_email', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          Text('Phone: $_phone', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          Text('Address: $_address', style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Update Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'New Password'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _updatePassword,
                    child: const Text("Update Password"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _logOut,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Log Out"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/homescreen');
                    },
                    child: const Text("Go to Home"),
                  ),
                ],
              ),
            ),
    );
  }
}
