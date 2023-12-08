part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final String cityName;
  final String temp;
  final String main;
  final String weatherImage;
  final String dateTime;
  final String sunrise;
  final String sunset;
  final List<Temp> forecast;
  final Function weatherImg;
  final Function convertTemp;
  final Function convertTimeWithWeek;
  final Function convertTime;
 
  WeatherSuccess({
    required this.cityName,
    required this.dateTime,
    required this.forecast,
    required this.main,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.weatherImage,
    required this.weatherImg,
    required this.convertTemp,
    required this.convertTimeWithWeek, 
    required this.convertTime
  });
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);
}

final class WeatherLoading extends WeatherState {}
