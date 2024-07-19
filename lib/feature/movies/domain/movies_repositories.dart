import 'dart:convert';

import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import "package:http/http.dart" as http;

class MoviesRepositories {
String baseMovieApi = "https://dummyapi.online/api/movies";

Future<List<MoviesModel>> fetchMovies() async {

     final response = await http.get(Uri.parse(baseMovieApi));
 try {

   if (response.statusCode == 200) {

    List<dynamic> json = jsonDecode(response.body);
    print(json);

    List<MoviesModel> movies =  json.map((movie)=> MoviesModel.fromJson(movie)).toList();
    return movies;
     
   }
   
 } catch (e) {
  print(response.statusCode);
  print("movies aaena");
  
throw Exception(e);
   
 }

 return [];
}

}