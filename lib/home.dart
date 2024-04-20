import 'package:bliss/add_story.dart';
import 'package:bliss/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> snapshot;

  HomeScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Image.asset("lib/logo_bliss.png"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(StoryForm());
                  },
                  child: Text("Add Story")),
              const Text(
                "CATEGORIES",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kcategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.pinkAccent,
                        ),
                        child: Center(child: Text(kcategories[index])),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                height: 10,
              ),
              const Text(
                "TOP RATED ",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: snapshot,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    int itemCount = snapshot.data!.length;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 250,
                                  width: 50,
                                  child: Image.asset(
                                    'lib/logo_bliss.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: 100,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    snapshot.data![index]['title'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // Container(
                              //   child: Text(
                              //     "Score: 4 / 5",
                              //     style: TextStyle(color: Colors.yellow),
                              //   ),
                              // )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
