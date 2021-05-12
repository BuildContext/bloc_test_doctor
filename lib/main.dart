import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/doctor_details_screen.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/home_screen.dart';
import 'package:bloc_test_doctor/ui/pages/webview_page/web_view_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == DoctorDetailsScreen.routeName) {
          return MaterialPageRoute(
              builder: (context) =>
                  DoctorDetailsScreen(doctor: settings.arguments as Doctor));
        } else if (settings.name == DoctorWebViewScreen.routeName) {
          return MaterialPageRoute(
              builder: (context) =>
                  DoctorWebViewScreen(url: settings.arguments as String));
        }
      },
    );
  }
}
