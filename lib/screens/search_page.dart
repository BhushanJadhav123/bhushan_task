import 'package:bhushan_task/bloc/search_movies/search_movies_bloc.dart';
import 'package:bhushan_task/common_widgets/custom_dialog.dart';
import 'package:bhushan_task/common_widgets/movie_card.dart';
import 'package:bhushan_task/common_widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final searchFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextField(
            controller: searchFieldController,
            autofocus: true,
            onSubmitted: (value) {
              if (searchFieldController.text.isEmpty ||
                  searchFieldController.text.length < 3) {
                customDialog(context);
                return;
              }
              BlocProvider.of<SearchMoviesBloc>(context)
                  .add(SearchMoviesByName(searchFieldController.text));
            },
            decoration: InputDecoration(
              hintText: "Search movie by name",
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: IconButton(
                  key: const Key("search icon"),
                  onPressed: () async {
                    if (searchFieldController.text.isEmpty ||
                        searchFieldController.text.length < 3) {
                      await customDialog(context);
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    BlocProvider.of<SearchMoviesBloc>(context)
                        .add(SearchMoviesByName(searchFieldController.text));
                  },
                  icon: const Icon(Icons.search, size: 30, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, searchBlocState) {
          if (searchBlocState is SearchMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (searchBlocState is SearchMoviesLoaded) {
            return searchBlocState.allMovies.isEmpty
                ? const Center(
                    child: Text("Movie not found with this name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  )
                : ListView.builder(
                    itemCount: searchBlocState.allMovies.length,
                    itemBuilder: (context, index) {
                      final movie = searchBlocState.allMovies[index];
                      return MovieCard(movie: movie);
                    });
          } else if (searchBlocState is SearchMoviesError) {
            return ShowErrorWidget(
              errorMessage: searchBlocState.errorMessage,
              onPress: () {
                BlocProvider.of<SearchMoviesBloc>(context)
                    .add(SearchMoviesByName(searchFieldController.text));
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
