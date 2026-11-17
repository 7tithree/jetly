import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingFormScreen extends StatefulWidget {
  final String jetName;

  const BookingFormScreen({super.key, required this.jetName});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passengerCountController = TextEditingController();
  final TextEditingController _flightTimeController = TextEditingController();
  final TextEditingController _departureLocationController = TextEditingController();
  final TextEditingController _destinationLocationController = TextEditingController();
  bool _isLoading = false;
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('user_email') ?? '';
    });
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost/jetly_app/book_jet.php'),
        body: {
          'email': _email,
          'jet_name': widget.jetName,
          'booking_date': _dateController.text,
          'passenger_count': _passengerCountController.text,
          'flight_time': _flightTimeController.text,
          'departure_location': _departureLocationController.text,
          'destination_location': _destinationLocationController.text,
        },
      );

      if (response.statusCode == 200 && response.body.contains('Booking successful')) {
        _showDialog('Success', 'Jet booked successfully!');
      } else {
        _showDialog('Error', 'Failed to book jet: ${response.body}');
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      _dateController.text = picked.toIso8601String().split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book ${widget.jetName}")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Booking for: ${widget.jetName}", style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: const InputDecoration(
                          labelText: "Select Booking Date",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please choose a date' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passengerCountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Passenger Count",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter passenger count' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _flightTimeController,
                        decoration: const InputDecoration(
                          labelText: "Flight Time",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter flight time' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _departureLocationController,
                        decoration: const InputDecoration(
                          labelText: "Departure Location",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter departure location' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _destinationLocationController,
                        decoration: const InputDecoration(
                          labelText: "Destination Location",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter destination location' : null,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitBooking,
                          child: const Text("Confirm Booking"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
