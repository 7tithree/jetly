import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'package:jetly_app/screens/intro_carousel_screen.dart';
import 'package:jetly_app/screens/profileview.dart';
import 'package:jetly_app/models/jet.dart';
import 'package:jetly_app/screens/booking_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const IntroCarouselScreen(),
    const SearchScreen(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jetly App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: _currentIndex == 0
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[200], 
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: const IntroCarouselScreen(),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: const Text(
                      "Available Jets",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final jets = [
                        Jet(
                          name: "Gulfstream 5650",
                          seats: 14,
                          range: "7,000 miles",
                          price: "\$29k per 1000 miles",
                          imagePath: 'assets/images/gulfstream-g550.jpg',
                        ),
                        Jet(
                          name: "Bombardier Challenger 300",
                          seats: 17,
                          range: "7,700 miles",
                          price: "\$32k per 1000 miles",
                          imagePath: 'assets/images/bombardier_challenger_300.jpg',
                        ),
                        Jet(
                          name: "Cessna Citation III",
                          seats: 12,
                          range: "3,500 miles",
                          price: "\$23k per 1000 miles",
                          imagePath: 'assets/images/cesna_citation_III.jpg',
                        ),
                      ];
                      final jet = jets[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(
                                jet.imagePath,
                                height: MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jet.name,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${jet.seats} seats • ${jet.range}",
                                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    jet.price,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingFormScreen(jetName: jet.name),
                                        ),
                                      );
                                    },
                                    child: const Text("Book Now"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 3,
                  ),
                ),
              ],
            )
          : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}