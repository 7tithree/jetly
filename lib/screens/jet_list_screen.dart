import 'package:flutter/material.dart';
import '../models/jet.dart';
import 'booking_form_screen.dart';

class JetListScreen extends StatelessWidget {
  const JetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jets = [
      Jet(name: "Gulfstream 5650", seats: 14, range: "7,000 miles", price: "\$29k per  1000 miles", imagePath: 'assets/images/gulfstream-g550.jpg'),
      Jet(name: "Bombardier Challenger 300", seats: 17, range: "7,700 miles", price: "\$32k per 1000 miles", imagePath: 'assets/images/bombardier_challenger_300.jpg'),
      Jet(name: "Cessna Citation III", seats: 12, range: "3,500 miles", price: "\$23k per 1000 miles", imagePath: 'assets/images/cesna_citation_III.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Available Jets")),
      body: ListView.builder(
        itemCount: jets.length,
        itemBuilder: (context, index) {
          final jet = jets[index];
          return ListTile(
            title: Text(jet.name),
            subtitle: Text("${jet.seats} seats • ${jet.range}"),
            trailing: Text(jet.price),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingFormScreen(jetName: jet.name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
