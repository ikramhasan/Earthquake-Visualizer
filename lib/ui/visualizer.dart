import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:flutter/material.dart';

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  static getData() async {
    var response = await http.get(
        'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv');
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,
          width: 2,
        ),
      ),
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomPaint(
            painter: Painter(data: snapshot.data),
            size: Size(MapData.width, MapData.height),
          );
        },
      ),
    );
  }
}

class Painter extends CustomPainter {
  final data;

  Painter({this.data});

  static var cLat = 0;
  static var cLon = 0;

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

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(data);
    for (var i = 1; i < lines.length; i++) {
      var earthquakes = lines[i].split(',');

      var lat = double.parse(earthquakes[1]);
      var lon = double.parse(earthquakes[2]);
      var mag = double.parse(earthquakes[4]);
      mag = pow(10, mag);
      mag = sqrt(mag);
      var magmax = sqrt(pow(10, 10));

      var x = mercX(lon) - centerX;
      var y = mercY(lat) - centerY;
      var d = ((mag - 0) / (magmax - 0)) * (180 - 0) + 0;
      var r = d.abs() / 2;
      //print(r);

      var center = Offset(x, y);
      var paint = Paint()..color = Colors.red;
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
