import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FlightHistoryScreen extends StatefulWidget {
  const FlightHistoryScreen({super.key});

  @override
  State<FlightHistoryScreen> createState() => _FlightHistoryScreenState();
}

class _FlightHistoryScreenState extends State<FlightHistoryScreen> {
  List<Map<String, dynamic>> _bookingHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookingHistory();
  }

  Future<void> _fetchBookingHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('user_email');

      if (email == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final response = await http.post(
        Uri.parse('http://localhost/jetly_app/book_jet.php'),
        body: {
          'action': 'get_history',
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _bookingHistory = List<Map<String, dynamic>>.from(data['bookings']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight History'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bookingHistory.isEmpty
              ? const Center(
                  child: Text(
                    'No history found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: _bookingHistory.length,
                  itemBuilder: (context, index) {
                    final booking = _bookingHistory[index];
                    return Card(
                      margin: const EdgeInsets.all(16.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jet: ${booking['jet_name']}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text("Date: ${booking['booking_date']}"),
                            Text("Passengers: ${booking['passenger_count']}"),
                            Text("Flight Time: ${booking['flight_time']}"),
                            Text("From: ${booking['departure_location']}"),
                            Text("To: ${booking['destination_location']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}