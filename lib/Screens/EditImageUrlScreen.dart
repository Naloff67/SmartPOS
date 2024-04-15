import 'package:flutter/material.dart';

class EditImageUrlScreen extends StatefulWidget {
  static const routeName = '/edit-image-url';

  @override
  _EditImageUrlScreenState createState() => _EditImageUrlScreenState();
}

class _EditImageUrlScreenState extends State<EditImageUrlScreen> {
  TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Image URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_imageUrlController.text.trim());
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
