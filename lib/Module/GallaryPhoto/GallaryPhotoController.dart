import 'dart:developer';

import 'package:flutter_photo_gallary/API/Repose/PhotoRepo.dart';
import 'package:flutter_photo_gallary/Model/TPhoto.dart';
import 'package:get/get.dart';

class GallaryPhotoController extends GetxController {
  var selectIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString orderBy = "latest".obs;
  RxString apikey = "gfmzrATxKCmmqQ5DJUkHgs0VBmWZzItmX22QdjggwN0".obs;
  List<TPhoto> photos = [];
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];
  getPhoto() async {
    isLoading.value = true;
    photos = await PhotoRepo.instant.getPhoto(
        'https://api.unsplash.com/photos/?per_page=33&order_by=${orderBy.value}&client_id=${apikey}');
    isLoading.value = false;
    update();
    log('message===========================>${photos.length}');
  }

  getPhotoOrderBy(String oreder) {
    orderBy.value = oreder;
    getPhoto();
  }

  @override
  void onInit() {
    getPhoto();
    // TODO: implement onInit
    super.onInit();
  }
}
