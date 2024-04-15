import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  void updateImageUrl(String newUrl) {
    _imageUrl = newUrl;
    notifyListeners();
  }
}
