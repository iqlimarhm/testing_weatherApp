import 'package:flutter/material.dart';
import 'package:testing/WeatherDetail.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  DetailPage({Key? key, this.weatherData}) : super(key: key);

  String formatTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.Hm().format(date); // Use a format that suits your needs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      backgroundColor: Color.fromARGB(255, 6, 10, 36),
                      elevation: 5,
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            weatherData?['name'] ?? 'Unknown City',
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (weatherData != null)
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  children: [
                    WeatherDetailItem(
                        'Temperature', '${weatherData!['main']['temp']}°C'),
                    WeatherDetailItem(
                        'Humidity', '${weatherData!['main']['humidity']}%'),
                    WeatherDetailItem(
                        'Wind', '${weatherData!['wind']['speed']} km/h'),
                    WeatherDetailItem(
                        'Visibility', '${weatherData!['visibility']} meters'),
                    WeatherDetailItem(
                        'Pressure', '${weatherData!['main']['pressure']} hPa'),
                    WeatherDetailItem(
                        'Cloudiness', '${weatherData!['clouds']['all']}%'),
                    WeatherDetailItem(
                        'Sunrise', formatTime(weatherData!['sys']['sunrise'])),
                    WeatherDetailItem(
                        'Sunset', formatTime(weatherData!['sys']['sunset'])),
                  ],
                ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 6, 10, 36),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Ingatlah untuk selalu mengenakan sunscreen atau sunblock, '
                  'topi, dan jaket untuk melindungi kulit Anda'
                  'dari paparan UV A dan UV B yang berbahaya.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
