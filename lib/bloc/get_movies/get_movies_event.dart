part of 'get_movies_bloc.dart';

@immutable
sealed class GetMoviesEvent {}

class GetMoviesLoad extends GetMoviesEvent {}

class GetMoviesLoadMore extends GetMoviesEvent {
  final List<Movie> currentLoadedMovies;
  final int pageNumber; // Page number that we want to load more.
  GetMoviesLoadMore(this.currentLoadedMovies, this.pageNumber);
}
