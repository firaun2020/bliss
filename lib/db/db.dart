import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMatters {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, List<String>>> getCategories() async {
    try {
      // Reference to the 'core_config' document in the 'main' collection
      DocumentReference documentRef =
          _firestore.collection('main').doc('core_config');

      // Fetch the document snapshot
      DocumentSnapshot documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        // Extract the 'categories' array from the document data
        List<dynamic> categories = documentSnapshot.get('categories');

        // Convert the dynamic list to a list of strings
        List<String> categoryList =
            categories.map((category) => category.toString()).toList();

        print(categoryList);

        // Return a map with 'categories' as key and categoryList as value
        return {'categories': categoryList};
      } else {
        print('Document does not exist');
        return {'categories': []};
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return {'categories': []};
    }
  }
  // GET TOP & return title, id and url

  Future<List<Map<String, dynamic>>> getTopStoriesData() async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents where 'top' field is set to TRUE
      QuerySnapshot querySnapshot =
          await storiesRef.where('top', isEqualTo: true).get();

      // Extract titles and ids from the documents
      List<Map<String, dynamic>> storiesData = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'] as String,
          'id': doc["id"],
          'url': doc['url'] as String,
        };
      }).toList();

      return storiesData;
    } catch (e) {
      print('Error fetching top stories: $e');
      return [];
    }
  }

// return a specific story

  Future<Map<String, dynamic>> getOneStory(int storyId) async {
    try {
      // Reference to the 'stories' collection
      CollectionReference storiesRef =
          FirebaseFirestore.instance.collection('stories');

      // Query documents where 'id' field is equal to storyId
      QuerySnapshot querySnapshot =
          await storiesRef.where('id', isEqualTo: storyId).get();

      // Check if the querySnapshot has any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Extract details from the document
        Map<String, dynamic> theStory = {
          'title': querySnapshot.docs.first['title'] as String,
          'story_text': querySnapshot.docs.first['story_text'] as String,
          'reads': querySnapshot.docs.first['reads'] as String,
          'likes': querySnapshot.docs.first['likes'],
          'url': querySnapshot.docs.first['url'] as String,
        };

        return theStory;
      } else {
        print('Document with id $storyId does not exist');
        return {};
      }
    } catch (e) {
      print('Error fetching the story: $e');
      return {};
    }
  }
}
