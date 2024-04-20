import 'package:bliss/add_story.dart';
import 'package:bliss/constants.dart';
import 'package:bliss/db/db.dart';
import 'package:bliss/story_home.dart';
import 'package:bliss/story_page.dart';
import 'package:bliss/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> snapshot;

  HomeScreen({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: bkgBlack,
          title: GestureDetector(
            onLongPress: () {
              Get.to(StoryForm());
            },
            child: Container(
              height: 50,
              width: 150,
              child: Image.asset("lib/bliss_typefont.png"),
            ),
          ),
        ),
        backgroundColor: bkgBlack,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: headingText(
                              Colors.white, klightBlue, "CATEGORIES"))),
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kcategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: klightBlue),
                        child: Center(
                            child: Text(
                          kcategories[index],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: headingText(
                              Colors.white, klightBlue, "TOP READ"))),
                ],
              ),
              const SizedBox(
                height: 10,
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
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            DataBaseMatters dataBaseMatters = DataBaseMatters();

                            Map<String, dynamic> storyToShow =
                                await dataBaseMatters
                                    .getOneStory(snapshot.data![index]["id"]);

                            Get.to(StoryHomePage(
                              storyObject: storyToShow,
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100,
                                    child: Image.network(
                                      snapshot.data![index]['url'],
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
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
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: headingText(Colors.white, klightBlue,
                              "SUBMIT YOUR EXPERIENCE"))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
