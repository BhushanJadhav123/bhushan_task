import 'package:bhushan_task/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetalPage extends StatelessWidget {
  final Movie movie;
  const MovieDetalPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Text(
                  "Title: ${movie.title}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Text(
                  "Overview: ${movie.overview}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rating: ${movie.rating}/10",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
                const SizedBox(height: 10),
                Text(
                  "Original langugae: ${movie.originalLanguage}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
                const SizedBox(height: 10),
                Text(
                  "Release date: ${movie.releaseDate}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
