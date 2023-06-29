import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempCubit extends Cubit<TempState> {
  TempCubit() : super(TempState.initial());

  void toggleUnit() {
    emit(
      state.copyWith(
          tempUnit: state.tempUnit == TempUnit.celsius
              ? TempUnit.fahrenheit
              : TempUnit.celsius),
    );
  }
}
