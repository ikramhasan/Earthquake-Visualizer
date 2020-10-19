import 'package:earthquake_visualizer/keys/key.dart';

class MapData {
  static double height = 720;
  static double width = 1280;

  static String mapSatelite = 'satellite-v9';
  static String mapDark = 'dark-v10';
  static String mapLite = 'light-v10';
  static String mapStreet = 'streets-v11';

  static double zoom = 1; //0.46;

  static String url =
      'https://api.mapbox.com/styles/v1/mapbox/$mapDark/static/0,0,$zoom,0/${width}x$height?access_token=$API_KEY';
}
