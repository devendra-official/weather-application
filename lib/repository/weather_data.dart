import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/location_model.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/repository/location.dart';

class WeatherExtract {
  final _api = dotenv.env['OPENWEATHER_KEY'];
  final _geoapi = dotenv.env['GEOAPIFY'];
  final _accuapi = dotenv.env['ACCUWEATHER'];

  Future<String> getLocation() async {
    Position position = await determineposition();
    double lat = position.latitude;
    double lon = position.longitude;

    final uri = await http.get(Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lon&lang=fr&apiKey=$_geoapi"));
    final loc = jsonDecode(uri.body);
    return loc["features"][0]["properties"]["city"];
  }

  Future getWeather({String? city}) async {
    city ??= city = await getLocation();
    final res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$_api"));
    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return Model.fromJson(data);
    } else {
      return BadRequest.fromJson(data);
    }
  }

  Future searchLocation(String city) async {
    final res = await http.get(Uri.parse(
        "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=$_accuapi&q=$city"));
    final data = jsonDecode(res.body);
    return Location.fromJson(data);
  }
}
