import 'dart:developer';

import 'package:dio/dio.dart';


   Dio dioHelper() {
    Dio dio =  Dio();
    dio.options.connectTimeout = 5000;
    dio.options.headers['content-Type'] = 'application/json';
    log('message=========>dio'+dio.toString());
    return dio;
  }

