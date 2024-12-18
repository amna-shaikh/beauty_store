import 'package:beauty_store/views/discover_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty App',
      theme: ThemeData(useMaterial3: true, fontFamily: "SF Pro"),
      home: const HomePage(),
    );
  }
}
