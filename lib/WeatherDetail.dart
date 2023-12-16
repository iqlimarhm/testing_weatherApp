import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final String label;
  final String value;

  WeatherDetailItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}

