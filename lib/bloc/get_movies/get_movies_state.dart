part of 'get_movies_bloc.dart';

@immutable
sealed class GetMoviesState {
  final List<Movie> allMovies;
  const GetMoviesState(this.allMovies);
}

final class GetMoviesInitial extends GetMoviesState {
  GetMoviesInitial() : super(<Movie>[]);
}

class GetMoviesLoading extends GetMoviesState {
  GetMoviesLoading() : super(<Movie>[]);
}

class GetMoviesMoreLoading extends GetMoviesState {
  const GetMoviesMoreLoading(List<Movie> allMovies) : super(allMovies);
}

class GetMoviesLoaded extends GetMoviesState {
  final int totalPages;
  const GetMoviesLoaded(final List<Movie> allMovies, this.totalPages)
      : super(allMovies);
}

class GetMoviesError extends GetMoviesState {
  final String errorMessage;
  GetMoviesError(this.errorMessage) : super([]);
}
