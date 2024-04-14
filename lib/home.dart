import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  )),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 10,
              ),
              Text(
                "CATEGORIES",
                style: TextStyle(fontSize: 20),
              ),
              // Horizontal scroll view for buttons
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 50,
                        child: Center(child: Text("$index")),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pinkAccent),
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
              // Vertical grid view for image tiles
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1, // Aspect ratio for the tiles
                  ),
                  itemCount: 9, // Replace with your item count
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: 250,
                              width: 50,
                              child: Image.asset(
                                'lib/logo_bliss.png', // Replace with your image asset
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 100,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Title ${index + 1}',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Score: 4 / 5",
                              style: TextStyle(color: Colors.yellow),
                            ),
                          )
                        ],
                      ),
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
