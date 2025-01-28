class Movie {
  final String title; // Movie title
  final String releaseDate; // Movie release date
  final String overview; // Movie overview
  final int
      rating; // Movie rating (Be carefull we need to round off it when we recieve response from api)
  final String originalLanguage; //  Original language of movie

  Movie({
    required this.originalLanguage,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    required this.title,
  });

  static Movie fromMap(Map data) {
    return Movie(
        originalLanguage: data["original_language"].toString().toUpperCase(),
        overview: data["overview"],
        rating: (data["vote_average"] as num).round(),
        releaseDate: data["release_date"],
        title: data["title"]);
  }
}
