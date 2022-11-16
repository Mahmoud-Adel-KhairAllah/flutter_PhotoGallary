import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomeWidgets {
  static  Widget customLoading({double size=20}) {
    return LoadingAnimationWidget.flickr(
        leftDotColor: Colors.blueGrey, rightDotColor: Colors.blue, size: size);
  }

  static Widget errorIcon() {
    return Icon(
      Icons.image_not_supported_rounded,
      color: Colors.grey,
    );
  }
}
