import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_udemy/constant/constant.dart';
import 'package:weather_app_udemy/cubits/temp_cubit/temp_settings_cubit.dart';
import 'package:weather_app_udemy/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app_udemy/pages/search_page.dart';
import 'package:weather_app_udemy/pages/settings_page.dart';
import 'package:weather_app_udemy/widget/error_dialog.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("weather App"),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchPage();
                  },
                ),
              );
              print(_city);
              if (_city != null) {
                context.read<WeatherCubit>().fetchWether(_city!);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: showWeather(),
    );
  }
}

String showTemperature(double temperature, BuildContext context) {
  final tempUnit = context.watch<TempCubit>().state.tempUnit;
  if (tempUnit == TempUnit.fahrenheit) {
    return '${((temperature * 9 / 5) + 32).toStringAsFixed(2)}℉';
  }
  return '${temperature.toStringAsFixed(2)}℃';
}

Widget showIcon(String icon) {
  return FadeInImage.assetNetwork(
    placeholder: '',
    image: 'http://$kIconHost/img/wn/$icon@4x.png',
    width: 96,
    height: 96,
  );
}

Widget formatText(String description) {
  final formattedString = description.titleCase;
  return Text(
    formattedString,
    style: const TextStyle(
      fontSize: 24.0,
    ),
    textAlign: TextAlign.center,
  );
}

Widget showWeather() {
  return BlocConsumer<WeatherCubit, WeatherState>(
    listener: (context, state) {
      if (state.weatherStatus == WeatherStatus.error) {
        errorDialog(context, state.customError.errMsg);
      }
    },
    builder: (context, state) {
      if (state.weatherStatus == WeatherStatus.initial) {
        return const Center(
          child: Text("Select search"),
        );
      }
      if (state.weatherStatus == WeatherStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.weatherStatus == WeatherStatus.error &&
          state.weather.name == '') {
        return const Center(
          child: Text("Select search"),
        );
      }
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.weather.name,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                TimeOfDay.fromDateTime(state.weather.lastUpdated)
                    .format(context),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                state.weather.country.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showTemperature(state.weather.temp, context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showTemperature(state.weather.tempMax, context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                showTemperature(state.weather.tempMin, context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              showIcon(state.weather.icon),
              Expanded(
                flex: 3,
                child: formatText(state.weather.description),
              ),
              const Spacer(),
            ],
          )
        ],
      );
    },
  );
}
