import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/note_pages/note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.white.withOpacity(.8),
      ),
      home: const NoteScreen(),
    );
  }
}

