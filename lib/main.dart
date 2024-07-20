import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import 'package:project_movies/feature/movies/data/models/user_model.dart';
import 'package:project_movies/feature/movies/domain/services/sharedprefs_services.dart';
import 'package:project_movies/feature/movies/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:project_movies/feature/movies/presentation/bloc/movies_bloc/bloc/movies_bloc.dart';
import 'package:project_movies/feature/movies/presentation/screens/home_screen.dart';

import 'package:project_movies/feature/movies/presentation/screens/login_screen.dart';
import 'package:project_movies/feature/movies/presentation/screens/movies_info.dart';
import 'package:project_movies/feature/movies/presentation/screens/profile_screen.dart';
import 'package:project_movies/feature/movies/presentation/screens/search_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenecesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => Login()),
  GoRoute(path: '/homeScreen', builder: (context, state){
    final user = state.extra as User;
    return HomeScreen(user : user);
  }),
  GoRoute(
    path: '/moviesInfo',
    builder: (context, state) {
      final movie = state.extra as MoviesModel;
      return MoviesInfo(movie: movie);
    },
  ),
  
  GoRoute(path: "/search", builder: (context, state) => SearchScreen()),
    GoRoute(path: "/profile", builder: (context, state) {
      final user = state.extra as User;
      return ProfileScreen(user : user);
    })
]);
