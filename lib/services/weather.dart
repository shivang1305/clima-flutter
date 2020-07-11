import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

//API Key
const apiKey = 'd849bea3f0d42d8f46898879b7091590';
const weatherApiURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  //to get weather as per the current location of the user
  Future getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();
    String url =
        '$weatherApiURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = new NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  //to get weather as per the city name entered by the user in search box
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$weatherApiURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = new NetworkHelper(url);
    var weatherData = await networkHelper.getData();
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
