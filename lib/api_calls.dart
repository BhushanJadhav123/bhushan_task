import 'package:bhushan_task/repository/movie_api.dart';
import 'package:bhushan_task/models/get_movies_model.dart';
import 'package:bhushan_task/models/movie_model.dart';

class ApiCalls {
  final apiRepository = MovieApiRepository();

  Future<GetMovies> getMovieCall(int pageNumber,
      {String movieName = ""}) async {
    final data =
        await apiRepository.getMovies(pageNumber, movieName: movieName);
    List<Movie> allMovies = [];
    final Map<String, dynamic> dataMap = data;
    // Adding movies in list
    for (var movie in dataMap["items"]) {
      allMovies.add(Movie.fromMap(movie));
    }

    return GetMovies(allMovies, dataMap["meta"]["number_of_pages"]);
  }
}
