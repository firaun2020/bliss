import 'package:bliss/constants.dart';
import 'package:bliss/db/db.dart';
import 'package:bliss/home.dart';
import 'package:bliss/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FanSubmit extends StatelessWidget {
  TextEditingController _name = TextEditingController();
  TextEditingController _story = TextEditingController();
  DataBaseMatters dataBaseMatters = DataBaseMatters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkgBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bkgBlack,
        title: GestureDetector(
          onLongPress: () {
            //Get.to(());
          },
          child: Container(
            height: 100,
            width: 300,
            child: Image.asset("lib/cu_hori.png"),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Name (Optional)',
                  hintText: 'Anonymous',
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _story,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Your Story',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Validate story field
                  if (_story.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your story')),
                    );
                  } else {
                    // Submit story
                    await dataBaseMatters.submitStory(
                      _name.text.isNotEmpty ? _name.text : 'Anonymous',
                      _story.text,
                    );

                    // Show submission confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Story submitted!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Future<List<Map<String, dynamic>>> storiesData =
                        dataBaseMatters.getTopStoriesData();

                    // Navigate back to previous screen
                    Get.to(HomeScreen(snapshot: storiesData));
                  }
                },
                child: Text('Submit Story'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
