// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_cubit.dart';

enum AppThemeState {
  light,
  dark,
}

class ThemeState extends Equatable {
  final AppThemeState appThemeState;
  const ThemeState({
    this.appThemeState = AppThemeState.light,
  });
  factory ThemeState.initial() {
    return const ThemeState();
  }
  @override
  List<Object> get props => [appThemeState];

  @override
  String toString() => 'ThemeState(appThemeState: $appThemeState)';

  ThemeState copyWith({
    AppThemeState? appThemeState,
  }) {
    return ThemeState(
      appThemeState: appThemeState ?? this.appThemeState,
    );
  }
}
