import 'dart:ui';

// Dynamic variables for the app
class Dimensions {
  static double pixelRadio = window.devicePixelRatio;
  static double screenHeight = window.physicalSize.height / pixelRadio;
  static double screenWidth = window.physicalSize.width / pixelRadio;

  static double ten = screenHeight / 83.49;
}
