import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_udemy/cubits/temp_cubit/temp_settings_cubit.dart';
import 'package:weather_app_udemy/cubits/theme_cubit/theme_cubit.dart';
import 'package:weather_app_udemy/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app_udemy/pages/home_page.dart';

import 'package:weather_app_udemy/repositories/weather_repository.dart';
import 'package:weather_app_udemy/services/weather_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempCubit>(
            create: (context) => TempCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) =>
                ThemeCubit(weatherCubit: context.read<WeatherCubit>()),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              theme: state.appThemeState == AppThemeState.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              home: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
