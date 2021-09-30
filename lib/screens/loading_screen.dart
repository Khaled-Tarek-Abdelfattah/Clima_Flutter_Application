import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
const apiKey = '33e213081c1fe1f9ffb045565b9c7729';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
   void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData()async{
      WeatherModel weatherModel=WeatherModel();
      var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder:(context) {
      return LocationScreen(weatherData);
    }
    )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
         child: SpinKitFadingCircle(
            color: Colors.white,
            size: 100.0,
          ),
      )
    );
  }
}
