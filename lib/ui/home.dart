import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:earthquake_visualizer/ui/visualizer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(MapData.url),
            Visualizer(),
          ],
        ),
      ),
    );
  }
}
