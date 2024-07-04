import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'my_app.dart';

Future main() async {
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}