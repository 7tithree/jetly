# Jetly App

Jetly is a Flutter-based private jet booking application that lets users browse aircraft, explore jet details, create an account, log in, and book flights with a simple mobile experience.

This project combines a Dart/Flutter frontend with a PHP + MySQL backend for authentication and booking data.

## Features

- Jet catalog with aircraft cards and pricing
- Search and browse available private jets
- Booking form with trip details such as date, flight time, departure, and destination
- User signup and login flow
- Profile management and booking history
- Dark mode toggle
- Modern UI designed for premium travel experiences

## Tech Stack

- Flutter + Dart
- Firebase Authentication and Firestore
- Provider and GetX for state management
- SharedPreferences for local persistence
- PHP REST-style endpoints for backend logic
- MySQL database

## Project Structure

```text
jetly_app/
├── android/                 # Android project files
├── assets/                 # Jet images and other app assets
├── ios/                    # iOS project files
├── lib/                    # Flutter application source code
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── utils/
│   └── widgets/
├── jetly_backend/          # PHP backend API files
│   ├── login.php
│   ├── signup.php
│   ├── book_jet.php
│   └── ...
├── test/                   # Flutter tests
├── pubspec.yaml            # Flutter package configuration
├── analysis_options.yaml
├── .gitignore
├── README.md
└── ...
```

## Prerequisites

Before running the app, make sure you have the following installed:

- Flutter SDK (3.7.2 or newer)
- Dart SDK
- Android Studio / Xcode / VS Code with Flutter extensions
- PHP + Apache or XAMPP/WAMP/MAMP for the backend
- MySQL database server

## Database Setup

Create a database named `jetly_db` and add the required tables.

Example schema:

```sql
CREATE DATABASE jetly_db;

USE jetly_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    jet_id INT NOT NULL,
    jet_name VARCHAR(255),
    booking_date VARCHAR(100),
    passenger_count INT,
    flight_time VARCHAR(100),
    departure_location VARCHAR(255),
    destination_location VARCHAR(255)
);
```

Note: The PHP files in `jetly_backend/` currently expect a local MySQL server with username `root` and an empty password, and they target the `jetly_db` database.

## Backend Setup

1. Start your local PHP server.
2. Place the `jetly_backend` folder in your web server root (for example, `htdocs` in XAMPP).
3. Ensure the backend URL resolves to:
   
   `http://localhost/jetly_backend`

4. Confirm your MySQL server is running and the `jetly_db` database exists.

## Running the App

From the project root:

```bash
flutter pub get
flutter run
```

If you want to run on a specific device or emulator:

```bash
flutter devices
flutter run -d <device_id>
```

## App Behavior

The current app structure routes users through a few core screens:

- Login screen
- Sign up screen
- Intro carousel
- Home screen with jet listings
- Search screen
- Profile screen
- Flight history
- Booking form

## Notes

This project is a working prototype and uses local PHP endpoints for authentication and booking logic. If you plan to deploy it to a real environment, it is recommended to:

- move sensitive data to environment variables
- use secure password hashing
- add validation and authentication tokens
- replace localhost-based APIs with a production backend service

## License

This project currently has no explicit license file. If you plan to publish or share it publicly, add a license that matches your intended usage.
