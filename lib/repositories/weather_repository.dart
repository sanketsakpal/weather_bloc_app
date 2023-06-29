// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:weather_app_udemy/exception/weather_exception.dart';
import 'package:weather_app_udemy/model/custom_error.dart';
import 'package:weather_app_udemy/model/direct_geocoding.dart';
import 'package:weather_app_udemy/model/weather.dart';

import 'package:weather_app_udemy/services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      if (kDebugMode) {
        print("$directGeocoding--geo--code--");
      }

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      if (kDebugMode) {
        print("$tempWeather---temp");
      }

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
