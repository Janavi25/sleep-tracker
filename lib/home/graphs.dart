import 'package:flutter/material.dart';
import 'package:sleep_tracker/helpers/charts.dart';

class DataVisual extends StatefulWidget {
  @override
  State<DataVisual> createState() => _DataVisualState();
}

class _DataVisualState extends State<DataVisual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0C16),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LineChartSample2()]),
    );
  }
}
