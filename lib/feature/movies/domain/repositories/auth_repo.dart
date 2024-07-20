import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_movies/feature/movies/data/models/user_model.dart';


class AuthRepo {


  Future<User> getUser(var username, var password) async {
    const String api = 'https://dummyjson.com/auth/login';
    try {
      final response = await http.post(Uri.parse(api),
          body: jsonEncode({'username': username, 'password': password}),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        User user = User(
            username: username,
            email: data['email'],
            firstName: data['firstName'],
            lastName: data['lastName'],
            gender: data['gender'],
            token: data['token'],
            id: data['id']);
        print(user);
        print("token aayo");
        print(response.body);
        return user;
      } else {
        print(response.statusCode);
        print("token aaena");
      }
    } catch (e) {
      throw Exception();
    }
    throw 0;
  }

  
}