// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'temp_settings_cubit.dart';

enum TempUnit { celsius, fahrenheit }

class TempState extends Equatable {
  final TempUnit tempUnit;
  const TempState({
    this.tempUnit = TempUnit.celsius,
  });

  factory TempState.initial() {
    return const TempState();
  }
  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempState(tempUnit: $tempUnit)';

  TempState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
