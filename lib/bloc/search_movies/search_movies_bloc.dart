import 'package:bhushan_task/api_calls.dart';
import 'package:bhushan_task/models/get_movies_model.dart';
import 'package:bhushan_task/models/movie_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final apiCalls = ApiCalls();
  SearchMoviesBloc() : super(SearchMoviesInitial()) {
    on<SearchMoviesByName>((event, emit) async {
      try {
        emit(SearchMoviesLoading());
        final GetMovies getMovieData =
            await apiCalls.getMovieCall(1, movieName: event.text);

        return emit(SearchMoviesLoaded(getMovieData.movies));
      } catch (e) {
        debugPrint("Search ERROR: $e");
        return emit(SearchMoviesError("Something went wrong"));
      }
    });
  }
}
