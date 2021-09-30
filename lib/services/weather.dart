import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apiKey = null/*you should replace null by the api key you should request from openweathermap*/;
class WeatherModel {
  Future<dynamic> getCityWeather(String city)async{
    NetworkHelper networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/'
        'weather?q=$city&appid=$apiKey');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather()async{
    LocationGetter locationGetter = LocationGetter();
    await locationGetter.getPosition();
    double longitude=locationGetter.long;
    double latitude=locationGetter.lat;
    NetworkHelper networkHelper=NetworkHelper('https://api.openweathermap.org/data/2.5/'
        'weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    var weatherData=await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
