import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryForm extends StatefulWidget {
  @override
  _StoryFormState createState() => _StoryFormState();
}

class _StoryFormState extends State<StoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _documentController = TextEditingController();
  final _titleController = TextEditingController();
  final _idController = TextEditingController();
  final _storyTextController = TextEditingController();
  final _readsController = TextEditingController();
  final _likesController = TextEditingController();
  String _category = "ROMANCE";
  bool _isTop = false;

  @override
  void dispose() {
    _documentController.dispose();
    _titleController.dispose();
    _idController.dispose();
    _storyTextController.dispose();
    _readsController.dispose();
    _likesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Story Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _documentController,
                decoration: InputDecoration(labelText: 'Document'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter document name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _storyTextController,
                decoration: InputDecoration(labelText: 'Story Text'),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter story text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _readsController,
                decoration: InputDecoration(labelText: 'Reads'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reads';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _likesController,
                decoration: InputDecoration(labelText: 'Likes'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter likes';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Category'),
                items: ["ROMANCE", "BDSM", "LGBTQ", "CONFESSION"]
                    .map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text("Top"),
                value: _isTop,
                onChanged: (bool value) {
                  setState(() {
                    _isTop = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save data to Firestore
                    await FirebaseFirestore.instance
                        .collection('stories')
                        .doc(_documentController.text)
                        .set({
                      'title': _titleController.text,
                      'id': int.parse(_idController.text),
                      'story_text': _storyTextController.text,
                      'reads': int.parse(_readsController.text),
                      'likes': int.parse(_likesController.text),
                      'category': _category,
                      'top': _isTop,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Story submitted!')),
                    );

                    // Clear form fields
                    _documentController.clear();
                    _titleController.clear();
                    _idController.clear();
                    _storyTextController.clear();
                    _readsController.clear();
                    _likesController.clear();
                    setState(() {
                      _category = "A";
                      _isTop = false;
                    });
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
