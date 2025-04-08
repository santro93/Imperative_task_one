import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/theme_bloc/theme_event.dart';
import 'package:imperative_task/bloc/theme_bloc/theme_state.dart';
import 'package:imperative_task/shared_preference/shared_preferences.dart';
import 'package:imperative_task/utility/constants/app_constants.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) async {
      final isDark = state.themeMode == ThemeMode.dark;
      await SharedPreferencesService.saveBool(StorageKeys.isDarkMode, !isDark);
      emit(ThemeState(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
    });

    _loadTheme();
  }

  void _loadTheme() async {
    final isDark =
        await SharedPreferencesService.getBool(StorageKeys.isDarkMode) ?? false;
    emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
