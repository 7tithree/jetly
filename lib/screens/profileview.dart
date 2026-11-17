import 'package:flutter/material.dart';
import 'package:jetly_app/screens/plans_screen.dart';
import 'package:jetly_app/screens/flight_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _name = 'User Name';
  String _email = 'user@example.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'User Name';
      _email = prefs.getString('email') ?? 'user@example.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_circle,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          Text(
            _name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _email,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          _buildRoundedContainer(
            'Review Acquired Plan',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlansScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildRoundedContainer('Flight Credit Balance: £76,000'),
          const SizedBox(height: 20),
          _buildRoundedContainer(
            'Flight History',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlightHistoryScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildRoundedContainer('Track Flight Status'),
          const SizedBox(height: 20),
          _buildRoundedContainer('Manage Payment Methods'),
          const SizedBox(height: 20),
          _buildRoundedContainer('See Upcoming Flights'),
        ],
      ),
    );
  }

  Widget _buildRoundedContainer(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}