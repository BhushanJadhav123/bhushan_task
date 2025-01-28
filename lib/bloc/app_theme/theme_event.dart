part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class SwitchToDarkTheme extends ThemeEvent {}

class SwitchToLightTheme extends ThemeEvent {}

class LoadSavedTheme extends ThemeEvent {}
