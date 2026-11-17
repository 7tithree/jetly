class Booking {
  final String userId;
  final String jetName;
  final String departure;
  final String destination;
  final String date;
  final int passengers;

  Booking({
    required this.userId,
    required this.jetName,
    required this.departure,
    required this.destination,
    required this.date,
    required this.passengers,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'jetName': jetName,
      'departure': departure,
      'destination': destination,
      'date': date,
      'passengers': passengers,
    };
  }
}