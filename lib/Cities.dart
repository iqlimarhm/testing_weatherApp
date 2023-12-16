import 'package:flutter/material.dart';

class Cities extends StatelessWidget {
  final List<String> cityList = [
    'Surabaya',
    'Sidoarjo',
    'Mojokerto',
    'Jember',
    'Banyuwangi',
    'Probolinggo',
    'Pasuruan',
    'Bondowoso',
    'Madiun',
    'Blitar',
    'Ponorogo',
    'Lumajang'
  ];

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
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: 100),
            children:
                cityList.map((city) => buildCityItem(city, context)).toList(),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCityItem(String city, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, city);
      },
      child: Card(
        color: Colors.white.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            city,
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 59, 41, 41),
            ),
          ),
        ),
      ),
    );
  }
}
