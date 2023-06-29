// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final Weather weather;
  final CustomError customError;

  const WeatherState({
    required this.weatherStatus,
    required this.weather,
    required this.customError,
  });

  factory WeatherState.initial() {
    return WeatherState(
        weatherStatus: WeatherStatus.initial,
        weather: Weather.initial(),
        customError: CustomError());
  }

  @override
  List<Object> get props => [weatherStatus, weather, customError];

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    Weather? weather,
    CustomError? customError,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weather: weather ?? this.weather,
      customError: customError ?? this.customError,
    );
  }

  @override
  String toString() =>
      'WeatherState(weatherStatus: $weatherStatus, weather: $weather, customError: $customError)';
}
