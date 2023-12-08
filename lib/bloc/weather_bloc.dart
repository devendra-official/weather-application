import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/repository/weather_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherGetData>(_getData);
  }

  _getData(WeatherGetData event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherModel = event.city != null
          ? await WeatherExtract().getWeather(city: event.city)
          : await WeatherExtract().getWeather();

      if (weatherModel.cod == "200") {
        final values = event.weatherConvert(weatherModel);

        return emit(WeatherSuccess(
            temp: values.$1,
            main: values.$2,
            weatherImage: values.$3,
            dateTime: values.$4,
            sunrise: values.$5,
            sunset: values.$6,
            cityName: values.$7,
            forecast: weatherModel.list,
            weatherImg: event.weatherImg,
            convertTemp: event.temperature,
            convertTime: event.convertTime,
            convertTimeWithWeek: event.convertTimeWithWeek
            ));
      } else {
        return emit(WeatherFailure(weatherModel.message));
      }
    } catch (e) {
      return emit(WeatherFailure("something went wrong"));
    }
  }
}
