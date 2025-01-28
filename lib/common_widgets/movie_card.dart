import 'package:bhushan_task/models/movie_model.dart';
import 'package:bhushan_task/screens/detail_page.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// If keyboard is open than unfocusing it.
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MovieDetalPage(movie: movie);
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text("Rating: ${movie.rating}/10",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text("Release date: ${movie.releaseDate}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
