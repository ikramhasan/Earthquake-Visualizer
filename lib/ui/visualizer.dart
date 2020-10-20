import 'package:earthquake_visualizer/ui/loading.dart';
import 'package:earthquake_visualizer/ui/painter.dart';
import 'package:http/http.dart' as http;

import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:flutter/material.dart';

enum EarthquakeType {
  ALL_DAY,
  ALL_WEEK,
  ALL_MONTH,
}

class Visualizer extends StatelessWidget {
  final EarthquakeType earthquakeType;

  Visualizer({this.earthquakeType});

  @override
  Widget build(BuildContext context) {
    String type;

    getData() async {
      if (earthquakeType == EarthquakeType.ALL_DAY) {
        type = 'all_day';
      } else if (earthquakeType == EarthquakeType.ALL_WEEK) {
        type = 'all_week';
      } else if (earthquakeType == EarthquakeType.ALL_MONTH) {
        type = 'all_month';
      }
      var response = await http.get(
          'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/$type.csv');
      return response.body;
    }

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
            return Loading();
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
