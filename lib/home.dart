import 'package:bliss/cat_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const CircleAvatar(
              backgroundColor: Colors.black,
              minRadius: 40,
              child: Icon(
                Icons.fork_left,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(CatHomeScreen());
                      // Handle card tap
                      print('Card $index tapped!');
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ListTile(
                        title: Text('Category ${index + 1}'),
                        subtitle: const Text('... '),
                        // Customize card content as needed
                      ),
                    ),
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
