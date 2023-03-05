import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future saveImage(XFile file, String path) async {
    try {
      await file.saveTo(path);
      imageCache.clearLiveImages();
      imageCache.clear();
    } catch (e) {
      log('saveImage ERROR: $e');
      throw Exception();
    }
  }
}
