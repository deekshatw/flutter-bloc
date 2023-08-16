import 'package:flutter/material.dart';
import 'package:tutorial_bloc/features/home/ui/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.teal,
    ),
    home: Home(),
  ));
}
