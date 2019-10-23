import 'package:flutter/painting.dart';

class BayColors {
  BayColors._();

  static BayColors _instance;

  factory BayColors() {
    if (_instance == null) _instance = BayColors._();
    return _instance;
  }

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFC1C1C1);
  static const Color blue = Color(0xFF57A5FF);
  static const Color yellow = Color(0xFFfAE332);
}
