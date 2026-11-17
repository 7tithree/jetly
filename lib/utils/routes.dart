import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'package:jetly_app/screens/login_screen.dart';
import 'package:jetly_app/screens/home_screen.dart';
import 'package:jetly_app/screens/booking_form_screen.dart';
import 'package:jetly_app/screens/signup_screen.dart';
import 'package:jetly_app/screens/profile_screen.dart';
import 'package:jetly_app/screens/intro_carousel_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),
  GetPage(name: '/profile', page: () => ProfileScreen()),
  GetPage(name: '/bookingform', page: () => BookingFormScreen(jetName: '',)),
  GetPage(name: '/introcarousel', page: () => IntroCarouselScreen()),
];