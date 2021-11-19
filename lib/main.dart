import 'package:flutter/material.dart';
import 'package:dynamic_profile_page/profile_page.dart';

void main() {
  runApp(const DynamicProfilePageApp());
}

class DynamicProfilePageApp extends StatelessWidget {
  const DynamicProfilePageApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const ProfilePage()
    );
  }
}