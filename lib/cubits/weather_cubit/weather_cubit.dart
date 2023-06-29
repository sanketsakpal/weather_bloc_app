// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app_udemy/model/custom_error.dart';
import 'package:weather_app_udemy/model/weather.dart';
import 'package:weather_app_udemy/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());

  Future<void> fetchWether(String city) async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(
          weatherStatus: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(weatherStatus: WeatherStatus.error, customError: e));
    }
  }
}
