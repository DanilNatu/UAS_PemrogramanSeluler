import 'package:flutter/material.dart';
import 'package:project1/halaman_listbarang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Barang',
      theme: ThemeData(),
      home: HalamanListbarang(),
    );
  }
}