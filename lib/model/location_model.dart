class Location {
  late List<LocationList> locationlist;

  Location.fromJson(List? json) {
    if (json == null) {
      locationlist = [];
    } else {
      locationlist = <LocationList>[];
      for (var element in json) {
        locationlist.add(LocationList.fromJson(element));
      }
    }
  }
}

class LocationList {
  late String localizedName;
  late Country country;
  late AdministrativeArea administrativeArea;

  LocationList.fromJson(Map<String, dynamic> json) {
    localizedName = json["LocalizedName"];
    country = Country.fromJson(json["Country"]);
    administrativeArea =
        AdministrativeArea.fromJson(json["AdministrativeArea"]);
  }
}

class Country {
  late String localizedName;

  Country.fromJson(Map<String, dynamic> json) {
    localizedName = json["LocalizedName"];
  }
}

class AdministrativeArea {
  late String localizedName;

  AdministrativeArea.fromJson(Map<String, dynamic> json) {
    localizedName = json["LocalizedName"];
  }
}
