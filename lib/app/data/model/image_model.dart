import 'package:flutter/foundation.dart';

class ImageModel extends ChangeNotifier {
  Uint8List? imageBytes;

  void setImageBytes(Uint8List bytes) {
    imageBytes = bytes;
    notifyListeners();
  }
}
