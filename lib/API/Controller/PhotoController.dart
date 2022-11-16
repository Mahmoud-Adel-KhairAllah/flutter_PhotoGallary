import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_photo_gallary/API/DioHelper.dart';

class PhotoController {
  static getPhoto(String path)  {
     return dioHelper().get(
      path,
      options: Options(responseType: ResponseType.json, method: 'GET'),
    );
    
  }
}
