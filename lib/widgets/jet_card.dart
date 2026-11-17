import 'package:flutter/material.dart';
import '../models/jet.dart';

class JetCard extends StatelessWidget {
  final Jet jet;
  final VoidCallback onTap;

  const JetCard({super.key, required this.jet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(jet.imagePath, height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(jet.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("${jet.seats} seats • ${jet.range} range", style: const TextStyle(color: Colors.white60)),
                  const SizedBox(height: 4),
                  Text("Starting at ${jet.price}", style: const TextStyle(color: Color(0xFFFFD700))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
