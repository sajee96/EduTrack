import 'package:edu_track/app_utils.dart';
import 'package:edu_track/registration_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colorPrimary,
      body: Center(child: Text("test"),),
    );
  }
}
