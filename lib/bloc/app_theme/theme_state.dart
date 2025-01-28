part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeDarkSwitched extends ThemeState {}

final class ThemeLightwitched extends ThemeState {}
