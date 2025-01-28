// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bhushan_task/bloc/app_theme/theme_bloc.dart';
import 'package:bhushan_task/bloc/get_movies/get_movies_bloc.dart';
import 'package:bhushan_task/bloc/search_movies/search_movies_bloc.dart';
import 'package:bhushan_task/common_widgets/movie_card.dart';
import 'package:bhushan_task/common_widgets/show_error.dart';
import 'package:bhushan_task/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int loadPageNumber = 1;
  final ScrollController scrollcontroller = ScrollController();
  @override
  void initState() {
    scrollcontroller.addListener(paginationLogic);
    super.initState();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeBlocState = BlocProvider.of<ThemeBloc>(context).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        leading: Switch(
          onChanged: (value) {
            if (themeBlocState is ThemeLightwitched ||
                themeBlocState is ThemeInitial) {
              BlocProvider.of<ThemeBloc>(context).add(SwitchToDarkTheme());
              return;
            }
            BlocProvider.of<ThemeBloc>(context).add(SwitchToLightTheme());
          },
          value: themeBlocState is ThemeLightwitched ||
              themeBlocState is ThemeInitial,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 36),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => SearchMoviesBloc(),
                        child: SearchPage(),
                      )));
            },
          )
        ],
      ),
      body: BlocBuilder<GetMoviesBloc, GetMoviesState>(
          builder: (context, getMovieState) {
        if (getMovieState is GetMoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (getMovieState is GetMoviesLoaded ||
            getMovieState is GetMoviesMoreLoading) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: getMovieState.allMovies.length,
                    controller: scrollcontroller,
                    itemBuilder: (context, index) {
                      final movie = getMovieState.allMovies[index];
                      return MovieCard(movie: movie);
                    }),
              ),
              if (getMovieState is GetMoviesMoreLoading) ...[
                Center(
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ]
            ],
          );
        } else if (getMovieState is GetMoviesError) {
          return ShowErrorWidget(
            errorMessage: getMovieState.errorMessage,
            onPress: () {
              BlocProvider.of<GetMoviesBloc>(context).add(GetMoviesLoad());
            },
          );
        }
        return Container();
      }),
    );
  }

  void paginationLogic() {
    final getBlocState = BlocProvider.of<GetMoviesBloc>(context).state;

    if (getBlocState is GetMoviesLoaded) {
      if ((scrollcontroller.position.pixels ==
              scrollcontroller.position.maxScrollExtent) &&
          (loadPageNumber < getBlocState.totalPages)) {
        loadPageNumber += 1;
        BlocProvider.of<GetMoviesBloc>(context)
            .add(GetMoviesLoadMore(getBlocState.allMovies, loadPageNumber));
      }
    }
  }
}
