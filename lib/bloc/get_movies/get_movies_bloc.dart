import 'package:bhushan_task/api_calls.dart';
import 'package:bhushan_task/models/get_movies_model.dart';
import 'package:bhushan_task/models/movie_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'get_movies_event.dart';
part 'get_movies_state.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final apiCalls = ApiCalls();
  GetMoviesBloc() : super(GetMoviesInitial()) {
    on<GetMoviesLoad>((event, emit) async {
      try {
        emit(GetMoviesLoading());
        // Start loading movie from starting. i.e pageNumber = 1
        final GetMovies getMovieData = await apiCalls.getMovieCall(1);
        return emit(
            GetMoviesLoaded(getMovieData.movies, getMovieData.totalPages));
      } catch (e) {
        debugPrint("Get movie error $e");
        return emit(GetMoviesError("Something went wrong"));
      }
    });

    on<GetMoviesLoadMore>((event, emit) async {
      try {
        final List<Movie> currentMoviesList = event.currentLoadedMovies;

        emit(GetMoviesMoreLoading(event.currentLoadedMovies));
        // Load given page number movies
        final GetMovies getMovieData =
            await apiCalls.getMovieCall(event.pageNumber);

        final List<Movie> updatedMoviesList = [
          ...currentMoviesList,
          ...getMovieData.movies
        ];

        return emit(
            GetMoviesLoaded(updatedMoviesList, getMovieData.totalPages));
      } catch (e) {
        debugPrint("Get movie error $e");
        return emit(GetMoviesError("Something went wrong"));
      }
    });
  }
}
