import 'package:flutter/material.dart';
import 'jet_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> allJets = [
    {
      'name': 'Airbus ACJ220',
      'seats': '18',
      'range': '6,000 miles',
      'price': '\$32k per 1000 miles',
      'imagePath': 'assets/images/airbus-ACJ220.jpg',
    },
    {
      'name': 'Bombadier Challenger 300',
      'seats': '17',
      'range': '7,700 miles',
      'price': '\$32k per 1000 miles',
      'imagePath': 'assets/images/bombardier_challenger_300.jpg',
    },
    {
      'name': 'Cessna Citation II',
      'seats': '12',
      'range': '3,500 miles',
      'price': '\$20k per 1000 miles',
      'imagePath': 'assets/images/cesna_citation_II.jpg',
    },
    {
      'name': 'Gulfstream G550',
      'seats': '14',
      'range': '7,000 miles',
      'price': '\$29k per 1000 miles',
      'imagePath': 'assets/images/gulfstream-g550.jpg',
    },
    {
      'name': 'Cessna Citation III',
      'seats': '12',
      'range': '3,500 miles',
      'price': '\$23k per 1000 miles',
      'imagePath': 'assets/images/cesna_citation_III.jpg',
    },
  ];

  List<Map<String, String>> filteredJets = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredJets = allJets;
  }

  void _searchJet(String query) {
    setState(() {
      filteredJets = allJets
          .where((jet) => jet['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Jets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _searchJet,
              decoration: const InputDecoration(
                labelText: 'Search for a Jet',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredJets.length,
                itemBuilder: (ctx, index) {
                  final jet = filteredJets[index];
                  return ListTile(
                    title: Text(jet['name']!),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JetDetailsScreen(jet: jet),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
