import 'package:flutter/material.dart';

AppBar appBar({required String text}) {
  return AppBar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    centerTitle: true,
    title: Text(text),
  );
}
