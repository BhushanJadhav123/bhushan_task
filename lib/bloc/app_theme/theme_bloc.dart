import 'package:bhushan_task/repository/local_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<SwitchToDarkTheme>((event, emit) {
      SharedPreferencesRepository.saveTheme(true);
      return emit(ThemeDarkSwitched());
    });

    on<SwitchToLightTheme>((event, emit) {
      SharedPreferencesRepository.saveTheme(false);
      return emit(ThemeLightwitched());
    });

    on<LoadSavedTheme>((event, emit) async {
      bool isDarkTheme = await SharedPreferencesRepository.getTheme();
      return emit(isDarkTheme ? ThemeDarkSwitched() : ThemeLightwitched());
    });
  }
}
