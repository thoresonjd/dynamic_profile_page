import 'package:flutter/material.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Setup"),)
    );
  }
}