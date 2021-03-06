import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String apiKey = '489b8ed3b7cc278c4acae512ecd7d2e0';
const String base_url = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper =
        NetworkHelper('$base_url?q=$city&appid=$apiKey&units=metric');
    //&units=metric to got temp in c  &units=imperel to get temp in fahrinhet
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$base_url?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    //&units=metric to got temp in c  &units=imperel to get temp in fahrinhet
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
