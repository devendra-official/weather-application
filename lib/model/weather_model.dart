class Model {
  late String cod;
  late String message;
  late int cnt;
  late List<Temp> list;
  late City city;

  Model({required this.cnt, required this.cod, required this.message});

  Model.fromJson(Map<String, dynamic> json) {
    cod = json["cod"].toString();
    message = json["message"].toString();
    cnt = json["cnt"];

    if (json["list"] != null) {
      list = <Temp>[];
      json["list"].forEach((value) {
        list.add(Temp.fromJson(value));
      });
    }

    city = City.fromJson(json["city"]);
  }
}

class Temp {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Wind wind;
  late String visibility;
  late String dttxt;

  Temp(
      {required this.dt,
      required this.dttxt,
      required this.main,
      required this.visibility,
      required this.weather,
      required this.wind});

  Temp.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = Main.fromJson(json["main"]);
    if (json["weather"] != null) {
      weather = <Weather>[];
      json["weather"].forEach((values) {
        weather.add(Weather.fromJson(values));
      });
    }
    wind = Wind.fromJson(json["wind"]);
    visibility = json["visibility"].toString();
    dttxt = json["dt_txt"];
  }
}

class Weather {
  late int id;
  late String main;

  Weather(
      {
      required this.id,
      required this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"];
  }
}

class Main {
  late String temp;
  late String pressure;
  late String seaLevel;
  late String grndLevel;
  late String humidity;

  Main(
      {required this.temp,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"].toString();
    pressure =    json['pressure'].toString();
    seaLevel =   json['sea_level'].toString();
    grndLevel = json['grnd_level'].toString();
    humidity =    json['humidity'].toString();
  }
}

class Wind {
  late String speed;

  Wind({required this.speed});
  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"].toString();
  }
}

class City {
  late int id;
  late String name;
  late int sunrise;
  late int sunset;

  City({
    required this.id,
    required this.name,
    required this.sunrise,
    required this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }
}
