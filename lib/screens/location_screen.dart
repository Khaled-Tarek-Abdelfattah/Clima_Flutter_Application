import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/Alert_screen.dart';
class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen(
      this.locationWeather
      );
  @override
  _LocationScreenState createState() => _LocationScreenState();
}
class _LocationScreenState extends State<LocationScreen> {
  double temp=0;
  int temperature=0;
  int condition=0;
  String cityName='';
  @override
  void initState(){
    super.initState();
    updateUi(widget.locationWeather);
  }
  void updateUi(dynamic weatherData){
    setState(() {
      temp=weatherData['main']['temp'];
      temperature=(temp-273.15).toInt();
      condition=weatherData['weather'][0]['id'];
      cityName=weatherData['name'];
    });
  }
  WeatherModel weatherModel=WeatherModel();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: ()  async{
                       var weatherData = await weatherModel.getLocationWeather();
                       updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      var city=await Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return CityScreen();
                      }
                      )
                      );
                      var weatherData = await weatherModel.getCityWeather(city);
                      if(weatherData==null){
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                          return AlertScreen();
                        }
                        )
                        );
                      }
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                       weatherModel.getWeatherIcon(condition) ,
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherModel.getMessage(temperature)+' in '+cityName,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
