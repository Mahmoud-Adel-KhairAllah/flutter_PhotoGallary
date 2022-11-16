import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_photo_gallary/API/Controller/PhotoController.dart';
import 'package:flutter_photo_gallary/Model/TPhoto.dart';

class PhotoRepo {
  static var instant = PhotoRepo();
  Future<List<TPhoto>> getPhoto(String path) async {
    List<TPhoto> photos = [];
    var response = await PhotoController.getPhoto(path);
    if (response.statusCode == 200) {
      log('message=========================>20000000000');
      response.data.forEach((photo) {
        log('message photo id =========>${TPhoto.fromJson(photo).id}');
        photos.add(TPhoto.fromJson(photo));
      });
      
    } else {
      log('errrorrrroooomessage==================>${response.toString()}');
    }

    return photos;
  }
}
