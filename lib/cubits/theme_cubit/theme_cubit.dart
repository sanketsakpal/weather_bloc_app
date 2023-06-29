// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_udemy/constant/constant.dart';

import 'package:weather_app_udemy/cubits/weather_cubit/weather_cubit.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;
  final WeatherCubit weatherCubit;
  ThemeCubit({
    required this.weatherCubit,
  }) : super(ThemeState.initial()) {
    weatherSubscription =
        weatherCubit.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.temp < kWarmOrNot) {
        emit(state.copyWith(appThemeState: AppThemeState.dark));
      } else {
        emit(state.copyWith(appThemeState: AppThemeState.dark));
      }
    });
  }
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
