import 'package:flutter/material.dart';

import 'scenes/Homepage.dart';

void main() {
  runApp(const PertCAL());
}

class PertCAL extends StatefulWidget {
  const PertCAL({Key? key}) : super(key: key);

  @override
  _PertCALState createState() => _PertCALState();
}

class _PertCALState extends State<PertCAL> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
