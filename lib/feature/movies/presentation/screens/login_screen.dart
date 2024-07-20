import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_movies/feature/movies/presentation/bloc/auth_bloc/auth_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 


  @override
  clear() {
    _username.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          Center(
              child: Container(
            height: height * .1,
            child: LottieBuilder.network(
                "https://lottie.host/63f09589-a540-4e4d-89cc-b50c59978a5e/t6tMUb4x2i.json"),
          ));
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.error,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        } else if (state is AuthSuccess) {
          final userJson = jsonEncode(state.user.toJson());
          context.go("/homeScreen/${Uri.encodeComponent(userJson)}");

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Logged in"),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,

          children: [
            Image.asset(
              'lib/assets/images/background.jpg',
            
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.overlay,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: height*.5,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.overlay,
                      color: Colors.black,
                      
                ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height*.02,),
                        Row(
                          children: [
                            SizedBox(width: width * .1),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Login",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  validator: (value) {
                                    if (value!.length > 100) {
                                      return "Can't have more than 100 letters";
                                    }
                                    if (value.length <= 0 || value.isEmpty) {
                                      return "Enter a username";
                                    }
                                  },
                                  controller: _username,
                                  decoration: InputDecoration(
                                     border: OutlineInputBorder(),
                                    
                                    hintText: "Username",
                                     errorStyle: TextStyle(color: Colors.amber),
                                    
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      
                                      fontSize: 18,
                                    ),
                                
                                  ),
                                ),
                                SizedBox(height: height * .01),
                                TextFormField(
                                  
                                  style: TextStyle(
                                  color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.length > 100) {
                                      return "Can't have more than 100 letters";
                                    }
                                    if (value!.length <= 0 || value.isEmpty) {
                                      return "Enter a password";
                                    }
                                  },
                                  controller: _password,
                                  decoration: InputDecoration(
                                    
                                
                                    border: OutlineInputBorder(),
                                    suffixIconColor: Colors.blue,
                                    errorStyle: TextStyle(color: Colors.amber),
                                    
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                       color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  
                                  ),
                                ),
                                SizedBox(
                                  height: height * .03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width*.75,
                                      child: ElevatedButton(
                                      
                                        
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                            )),
                                       
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    const Color.fromARGB(255, 244, 26, 10)),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              BlocProvider.of<AuthBloc>(context)
                                                  .add(LoginButtonPressedEvent(
                                                      username: _username.text,
                                                      password: _password.text));
                                              clear();
                                            }
                                          },
                                          child: Text("Sign In",
                                              style: GoogleFonts.getFont('Roboto',
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromARGB(
                                                        255, 235, 241, 247),
                                                  )))),
                                    ),
                                  ],
                                ),
                                SizedBox(width: width * .05)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
