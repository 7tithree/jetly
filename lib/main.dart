import 'package:flutter/material.dart';
import 'package:jetly_app/screens/home_screen.dart';
import 'package:jetly_app/screens/intro_carousel_screen.dart';
import 'package:jetly_app/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jetly_app/screens/profile_screen.dart';
import 'package:jetly_app/screens/login_screen.dart';
import 'package:jetly_app/services/auth_service.dart';
import 'package:jetly_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');
    if (isDarkMode != null && isDarkMode) {
      setState(() {
        _themeMode = ThemeMode.dark;
      });
    } else {
      setState(() {
        _themeMode = ThemeMode.light;
      });
    }
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_themeMode == ThemeMode.light) {
      setState(() {
        _themeMode = ThemeMode.dark;
      });
      prefs.setBool('isDarkMode', true);
    } else {
      setState(() {
        _themeMode = ThemeMode.light;
      });
      prefs.setBool('isDarkMode', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jetly App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: FutureBuilder<String?>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return ProfileScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/profile': (context) => ProfileScreen(),
        '/homescreen': (context) => HomeScreen(),
        '/introcarousel': (context) => IntroCarouselScreen()
      },

      builder: (context, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _toggleTheme,
            child: Icon(_themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
          ),
          body: child,
        );
      },
    );
  }

  Future<String?> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs == null) {
      print('Error: SharedPreferences not initialized');
      return null;
    }
    String? email = prefs.getString('email');
    print('Retrieved email: $email');
    return email;
  }

  Future<void> saveLoginStatus(String email, Map<String, dynamic> data) async {
    if (data['success'] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs == null) {
        print('Error: SharedPreferences not initialized');
        return;
      }
      prefs.setString('email', email);
      print('Email saved: $email');
    }
  }

  Future<void> retrieveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    print('Email retrieved: $email');
  }
}
