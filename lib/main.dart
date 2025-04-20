import 'package:flutter/material.dart';
import 'package:wathef/app.dart';
import 'package:wathef/locator.dart';

void main() async {
  await setupLocator();
  runApp(const MyApp());
}
