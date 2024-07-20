import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_movies/feature/movies/data/models/user_model.dart';
import 'package:project_movies/feature/movies/domain/repositories/auth_repo.dart';
import 'package:project_movies/feature/movies/domain/services/sharedprefs_services.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressedEvent>(_login);
  }

  Future<void> _login(
      LoginButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      User user =
          await AuthRepo().getUser(event.username, event.password);
      print("user aayo ${user.email}");
      print("user aayo ${user.token}");

      SharedPreferenecesService.setString(key: 'token', value: user.token);

      // final Sejan = SharedPreferenecesService.getString(key: 'token');
      SharedPreferenecesService.setString(
          key: "currentUser", value: jsonEncode(user));
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: "wrong username or password"));
      print("error token aayo $e");
    }
  }
}