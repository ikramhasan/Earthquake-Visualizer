import 'dart:convert';
import 'dart:math';

import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:flutter/material.dart';

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

      double opacity = 0.2;
      double radius = 1;
      if (mag < 0) {
        opacity = 0.2;
      } else if (mag > 0 && mag < 1) {
        opacity = 0.3;
      } else if (mag > 1 && mag < 2) {
        opacity = 0.4;
        radius = 2;
      } else if (mag > 2 && mag < 3) {
        opacity = 0.5;
        radius = 3;
      } else if (mag > 3 && mag < 4) {
        opacity = 0.6;
        radius = 3;
      } else if (mag > 4 && mag < 5) {
        opacity = 0.7;
        radius = 4;
      } else if (mag > 5) {
        opacity = 0.8;
        radius = 5;
      }
      mag = pow(10, mag);
      mag = sqrt(mag);
      var magmax = sqrt(pow(10, 10));

      var x = mercX(lon) - centerX;
      var y = mercY(lat) - centerY;
      var d = ((mag - 0) / (magmax - 0)) * (180 - 0) + 0;
      var r = d.abs() / 2;

      var center = Offset(x, y);
      var paint = Paint()..color = Colors.red.withOpacity(opacity);
      canvas.drawCircle(center, 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
