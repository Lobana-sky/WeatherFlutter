// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  int tempreture;
  String cityName;
  String msg;
  @override
  void initState() {
    super.initState();
    //locationWeather is in LocationScreen class and not in LocationScreen State so we can reach to it by widget.

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic decodedData) {
    setState(() {
      if (decodedData == null) {
        cityName = '';
        tempreture = 0;
        weatherIcon = 'Error';
        msg = 'Unable to fetch weather data';
        return;
      }
      var condition = decodedData['weather'][0]['id'];
      cityName = decodedData['name'];
      double temp = decodedData['main']['temp'];
      tempreture = temp.toInt();

      weatherIcon = weatherModel.getWeatherIcon(condition);
      msg = weatherModel.getMessage(tempreture) + " In " + cityName + "!";
    });
  }

  @override
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
                  FlatButton(
                    onPressed: () async {
                      // getLocationWeather has a future return value
                      // we should be sure that weatherData not null to pass  to updateUI
                      // so we put await and async ...
                      var weatherData = await weatherModel.getLocationWeather();

                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var cityTyped = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );

                      if (cityTyped != null) {
                        var weatherData =
                           await weatherModel.getCityWeather(cityTyped);
                        updateUI(weatherData);
                      }
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
                    Text(
                      '$tempreture°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  msg,
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
