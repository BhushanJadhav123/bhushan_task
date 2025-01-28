part of 'search_movies_bloc.dart';

@immutable
sealed class SearchMoviesEvent {}

class SearchMoviesByName extends SearchMoviesEvent {
  final String text;
  SearchMoviesByName(this.text);
}
