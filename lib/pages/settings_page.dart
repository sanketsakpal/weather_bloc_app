import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_udemy/cubits/temp_cubit/temp_settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          title: const Text("Temperature Unit"),
          subtitle: const Text("Celsius/Fahrenheit (Default: Celsius )"),
          trailing: Switch(
              value:
                  context.watch<TempCubit>().state.tempUnit == TempUnit.celsius,
              onChanged: (_) {
                context.read<TempCubit>().toggleUnit();
              }),
        ),
      ),
    );
  }
}
