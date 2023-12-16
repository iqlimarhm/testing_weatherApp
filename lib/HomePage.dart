import 'package:flutter/material.dart';
import 'package:testing/DetailPage.dart';
import 'package:testing/ForeCastDay.dart';
import 'package:testing/Cities.dart';
// import 'package:testing/main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatelessWidget {
  Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
    final apiKey = '718bb0f9e4f7b7a84a4df5d21e7c07aa';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchWeatherData('Malang'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoading(context);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final cityName =
                snapshot.data?['name'] as String? ?? 'Unknown City';
            final dt = snapshot.data?['dt'];
            final dateTime = dt != null
                ? DateTime.fromMillisecondsSinceEpoch(dt * 1000)
                : DateTime.now();
            final formattedDate = DateFormat.yMMMMd().format(dateTime);
            final weather = snapshot.data?['weather'];
            final weatherIcon = weather != null && weather.isNotEmpty
                ? weather[0]['icon'] as String? ?? '01d'
                : '01d';

            return buildWeatherContent(
                context, cityName, formattedDate, weatherIcon, snapshot.data);
          }
        },
      ),
    );
  }

  Widget buildWeatherContent(
      BuildContext context,
      String cityName,
      String formattedDate,
      String weatherIcon,
      Map<String, dynamic>? weatherData) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(weatherData: weatherData)),
              );
            },
            child: Column(
              children: [
                Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                Image.network(
                  'https://openweathermap.org/img/w/$weatherIcon.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cities()),
            );
          },
          child: Text(
            'Pilih Lokasi',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Text(
                'Perkiraan Cuaca',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 16),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ForecastDay(
                      'Senin',
                      'assets/img/2.png',
                      '18 Desember 2023',
                    ),
                    ForecastDay(
                      'Selasa',
                      'assets/img/4.png',
                      '19 Desember 2023',
                    ),
                    ForecastDay(
                      'Rabu',
                      'assets/img/13.png',
                      '19 Desember 2023',
                    ),
                    ForecastDay(
                      'Kamis',
                      'assets/img/1.png',
                      '20 Desember 2023',
                    ),
                    ForecastDay(
                      'Jumat',
                      'assets/img/5.png',
                      '21 Desember 2023',
                    ),
                    ForecastDay(
                      'Sabtu',
                      'assets/img/6.png',
                      '22 Desember 2023',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
