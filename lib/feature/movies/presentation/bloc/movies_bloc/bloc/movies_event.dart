part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

final class fetchMovies extends MoviesEvent{
  final int? id;
  final String? searchQuery;
fetchMovies({ this.id, this.searchQuery});
}
