part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  List<LocationList> cityList;
  LocationSuccess({required this.cityList});
}

final class LocationFailed extends LocationState {
  final String msg;

  LocationFailed({this.msg = "can't get location"});
}
