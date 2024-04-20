import 'package:bliss/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package for navigation

class LandingPage extends StatefulWidget {
  Future<List<Map<String, dynamic>>> topStories;
  LandingPage({super.key, required this.topStories});

  @override
  _LandingPageState createState() => _LandingPageState(topstories: topStories);
}

class _LandingPageState extends State<LandingPage> {
  bool showProgress = true;
  Future<List<Map<String, dynamic>>> topstories;
  _LandingPageState({required this.topstories});

  @override
  void initState() {
    super.initState();
    _navigateToHomeScreen();
  }

  _navigateToHomeScreen() async {
    // Delay for 2 seconds
    await Future.delayed(Duration(seconds: 1));

    // Navigate to HomeScreen
    Get.off(HomeScreen(
      snapshot: topstories,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/logo_bliss.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
                child: Text("Thank You For Choosing Our Product"),
              ),
              Visibility(
                visible: showProgress,
                child: const CircularProgressIndicator(
                  color: Colors.pink,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
