import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieApiRepository {
  /// Get movies by name and pages.
  Future getMovies(int pageNumber, {String movieName = ""}) async {
    var headers = {
      'x-rapidapi-host':
          'tmdb-movies-and-tv-shows-api-by-apirobots.p.rapidapi.com',
      'x-rapidapi-key': '0e176c21e3msh4799cb00efb76fep193ad9jsn844adc6ac38c'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://tmdb-movies-and-tv-shows-api-by-apirobots.p.rapidapi.com/v1/tmdb?name=$movieName&page=$pageNumber'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var apiResponse = await response.stream.bytesToString();
      var responseDecode = jsonDecode(apiResponse);

      return responseDecode;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
