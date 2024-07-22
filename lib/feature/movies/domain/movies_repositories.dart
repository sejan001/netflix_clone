import 'dart:convert';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import "package:http/http.dart" as http;

class MoviesRepositories {
  String baseMovieApi = "https://freetestapi.com/api/v1/movies";

  Future<List<MoviesModel>> fetchMovies({int? id, int? limit, String? searchQuery, String? name, String? order}) async {
    String url = baseMovieApi;

     if (searchQuery != null) {
      url = "$baseMovieApi?search=$searchQuery";
    }

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          List<MoviesModel> movies = jsonResponse.map((movie) => MoviesModel.fromJson(movie)).toList();
          return movies;
        } else if (jsonResponse is Map<String, dynamic>) {
          MoviesModel movie = MoviesModel.fromJson(jsonResponse);
          return [movie]; 
        }
      } else {
        print("Failed to load movies: ${response.statusCode}");
        throw Exception("Failed to load movies: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception(e);
    }

    return [];
  }
}
