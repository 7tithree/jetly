import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  String _acquiredPlan = 'Basic';

  @override
  void initState() {
    super.initState();
    _loadAcquiredPlan();
  }

  Future<void> _loadAcquiredPlan() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _acquiredPlan = prefs.getString('acquired_plan') ?? 'Basic';
    });
  }

  Future<void> _updateAcquiredPlan(String plan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('acquired_plan', plan);
    setState(() {
      _acquiredPlan = plan;
    });
  }

  @override
  Widget build(BuildContext context) {
    final basicPlan = [
      'Concierge Services',
      'In-flight Catering',
      'Lounge Access',
    ];

    final reserveMembershipPlan = [
      ...basicPlan,
      'Exclusive Benefits and Discounts to Escapade Partners',
      'Priority Booking and Discounts',
      'Exclusive Members Events',
      'Car Services',
      'Discounted Escapades',
      'Dedicated Personal Account Manager',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Plans'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanCard(
                title: 'Basic Plan',
                price: 'Free',
                features: basicPlan,
                onTap: () => _updateAcquiredPlan('Basic'),
              ),
              const SizedBox(height: 20),
              _buildPlanCard(
                title: 'Reserve Membership Plan',
                price: '\$100/month',
                features: reserveMembershipPlan,
                onTap: () => _updateAcquiredPlan('Reserve Membership'),
              ),
              const SizedBox(height: 30),
              Text(
                'Acquired Plan: $_acquiredPlan',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  price,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check, color: Colors.green, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: onTap,
                child: const Text('Select Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}