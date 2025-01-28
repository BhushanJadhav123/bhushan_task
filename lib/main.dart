import 'package:bhushan_task/bloc/app_theme/theme_bloc.dart';
import 'package:bhushan_task/bloc/get_movies/get_movies_bloc.dart';
import 'package:bhushan_task/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tasks which is done is given below:
/// Bloc State managment is used: Done
/// Api integration: Done
/// Search functionality: Done
/// Dark theme support: Done
/// Retry Functionality: Done (Send pageNumber 0 in api you will get Retry button)
/// Movie Detail page: Done
/// Pagination support: Dne
/// Error handling: Done (Showing same error messages for all exceptions)

/// Pending Tasks: Add favourite funclionality & Test cases
/// I know how to implement this things but due to time constraint I am not able to do this.

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ThemeBloc()..add(LoadSavedTheme()),
        child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetMoviesBloc()..add(GetMoviesLoad()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeState is ThemeDarkSwitched
              ? ThemeData.dark(useMaterial3: true).copyWith(
                  cardTheme: const CardTheme(color: Colors.white12),
                  textTheme: const TextTheme(
                      bodyMedium: TextStyle(
                    color: Colors.white,
                  )))
              : ThemeData.light(useMaterial3: true).copyWith(
                  cardTheme: const CardTheme(color: Colors.white12),
                  textTheme: const TextTheme(
                      bodyMedium: TextStyle(
                    color: Colors.black,
                  ))),
          home: HomePage(),
        );
      }),
    );
  }
}
