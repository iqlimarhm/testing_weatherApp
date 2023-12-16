import 'package:flutter/material.dart';

class ForecastDay extends StatelessWidget {
  final String day;
  final String imagePath;
  final String date;

  ForecastDay(this.day, this.imagePath, this.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: ListTile(
        leading: Image.asset(imagePath, width: 48, height: 48),
        title: Text(day, style: TextStyle(color: Colors.white)),
        subtitle: Text(date, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
