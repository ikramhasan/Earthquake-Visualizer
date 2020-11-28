import 'package:earthquake_visualizer/data/map_data.dart';
import 'package:earthquake_visualizer/ui/visualizer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EarthquakeType type = EarthquakeType.ALL_DAY;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: width >= 1280
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Earthquake Visualizer",
                        style: GoogleFonts.ubuntu(
                            fontSize: 22, color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' by Ikram Hasan',
                            style: GoogleFonts.ubuntu(
                              fontSize: 22,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Stack(
                      //alignment: Alignment.center,
                      children: [
                        Image(
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text('Error Loading map.'),
                          ),
                          image: NetworkImage(MapData.url),
                        ),
                        Visualizer(
                          earthquakeType: type,
                        ),
                      ],
                    ),
                  ),
                  buttonRow(),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    Text(
                      'Sorry!!!',
                      style:
                          GoogleFonts.ubuntu(fontSize: 22, color: Colors.red),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'You need a bigger screen (1280p or higher) to view this project.',
                      style:
                          GoogleFonts.ubuntu(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  buttonRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Day',
              style: GoogleFonts.ubuntu(fontSize: 16),
            ),
          ),
          onPressed: () {
            setState(() {
              type = EarthquakeType.ALL_DAY;
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Week',
              style: GoogleFonts.ubuntu(fontSize: 16),
            ),
          ),
          onPressed: () {
            setState(() {
              type = EarthquakeType.ALL_WEEK;
            });
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Month',
              style: GoogleFonts.ubuntu(fontSize: 16),
            ),
          ),
          onPressed: () {
            setState(() {
              type = EarthquakeType.ALL_MONTH;
            });
          },
        ),
      ),
    ]);
  }
}
