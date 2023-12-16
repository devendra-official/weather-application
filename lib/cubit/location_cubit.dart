import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/model/location_model.dart';
import 'package:weather/repository/weather_data.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  void searchcity(String city) async {
    try {
      List<LocationList> cityList;
      ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return emit(
            LocationFailed(msg: "You are not connected to any network"));
      }
      emit(LocationLoading());
      if (city.isEmpty) {
        cityList = [];
        return emit(LocationInitial());
      }
      Location locationData = await WeatherExtract().searchLocation(city);
      if (locationData.locationlist.isEmpty) {
        return emit(LocationFailed(msg: "No results found"));
      }
      cityList = locationData.locationlist;
      return emit(LocationSuccess(cityList: cityList));
    } catch (e) {
      return emit(LocationFailed(msg: "failed fetch location"));
    }
  }
}
