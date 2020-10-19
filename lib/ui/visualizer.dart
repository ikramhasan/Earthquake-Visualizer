import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:flutter/material.dart';

class Visualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
      child: CustomPaint(
        painter: Painter(),
        size: Size(MapData.width, MapData.height),
      ),
    );
  }
}

class Painter extends CustomPainter {
  static var cLat = 0;
  static var cLon = 0;

  // Bangladesh = 23.6850° N, 90.3563° E
  static var lat = 23.6850;
  static var lon = 90.3563;

  static num degreesToRads(num deg) {
    return (deg * pi) / 180.0;
  }

  static mercX(var lon) {
    lon = degreesToRads(lon);
    var a = (256 / pi) * pow(2, MapData.zoom);
    var b = lon + pi;
    return a * b;
  }

  static mercY(var lat) {
    lat = degreesToRads(lat);
    var a = (256 / pi) * pow(2, MapData.zoom);
    var b = tan(pi / 4 + lat / 2);
    var c = pi - log(b);
    return a * c;
  }

  static var centerX = mercX(cLon);
  static var centerY = mercX(cLat);

  var x = mercX(lon) - centerX;
  var y = mercY(lat) - centerY;

  static var earthquake;

  static getData() async {
    var response = await http.get(
        'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.csv');

    earthquake = response.body;
  }

  @override
  void paint(Canvas canvas, Size size) {
    getData();
    for (int i = 0; i < earthquake.length; i++) {
      var data = earthquake[i].split(',');
    }
    canvas.translate(size.width / 2, size.height / 2);
    var center = Offset(x, y);
    var paint = Paint()..color = Colors.red;
    canvas.drawCircle(center, 4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
