part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherGetData extends WeatherEvent {
  final String? city;

  WeatherGetData({this.city});

  weatherConvert(Model weatherModel) {
    // Getting temperature in celcius and converting to String
    String temp = temperature(weatherModel.list[0].main.temp);

    // Weather status
    String desc = weatherModel.list[0].weather[0].main;

    // Weather status image
    int weatherId = weatherModel.list[0].weather[0].id;
    String image = weatherImg(weatherId);

    // Getting DateTime
    DateTime date = DateTime.parse(weatherModel.list[0].dttxt);
    String time = DateFormat.yMEd().format(date);

    // Sunrise and Sunset
    City city = weatherModel.city;

    String sunrise = convertTime(city.sunrise);
    String sunset = convertTime(city.sunset);

    // City Name
    String cityName = weatherModel.city.name;

    return (temp, desc, image, time, sunrise, sunset, cityName);
  }

  String convertTime(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat.Hm().format(dateTime);
  }

  String convertTimeWithWeek(String dtTxt){
    DateTime date = DateTime.parse(dtTxt);
    return "${DateFormat.E().format(date)} ${DateFormat.Hm().format(date)}";
  }

  String weatherImg(int weatherId){
    if (weatherId >= 200 && weatherId <= 232) {
      return "assets/weather is/thunder.png";
    } else if (weatherId >= 300 && weatherId <= 321) {
      return "assets/weather images/drizzel.png";
    } else if (weatherId >= 500 && weatherId <= 531) {
      return "assets/weather images/rain.png";
    } else if (weatherId >= 600 && weatherId <= 622) {
      return "assets/weather images/snow.png";
    } else if (weatherId >= 701 && weatherId <= 781) {
      return "assets/weather images/atmosphere.png";
    } else if (weatherId == 800) {
      return "assets/weather images/clear.png";
    } else {
      return "assets/weather images/clouds.png";
    }
  }

  String temperature(String temp){
    double tp = double.parse(temp) - 273.15;
    return tp.toStringAsFixed(2);
  }
}
