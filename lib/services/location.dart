import 'package:location/location.dart';
class LocationGetter{
  Location position=Location();
  double long=0;
  double lat=0;
  Future<void> getPosition() async{
      var currentLocation = await position.getLocation();
      long=(currentLocation.longitude??0).toDouble();
      lat=(currentLocation.latitude??0).toDouble();
  }
}