import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import 'package:project_movies/feature/movies/domain/movies_repositories.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {

    on<fetchMovies>(fetchMovie);

  }
    Future<void> fetchMovie( fetchMovies event , Emitter<MoviesState> emit) async {

    emit(MoviesLoading());
     try {
      final List<MoviesModel> movies = await MoviesRepositories().fetchMovies();
      print("movies fetch vayoo");
      emit(MoviesLoaded(movies: movies));
       
     } catch (e) {
      print("movies fetch vaenaa");
      throw Exception(e);
       
     }
     ;
  }
}
