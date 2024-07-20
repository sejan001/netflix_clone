import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 3), (){
    context.go("/homeScreen");
   });
  }



  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height*.1;
      double width = MediaQuery.sizeOf(context).width*.1;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
      

          child: Image.asset("lib/assets/videos/netflixGif.gif",fit: BoxFit.contain,))
                
              ),
      );
    
  }
}