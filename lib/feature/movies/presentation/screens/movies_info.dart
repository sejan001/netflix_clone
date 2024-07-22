import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/assets/datas/trailer_lists.dart';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';



class MoviesInfo extends StatefulWidget {
  final MoviesModel movie;

  const MoviesInfo({super.key, required this.movie});

  @override
  State<MoviesInfo> createState() => _MoviesInfoState();
}

class _MoviesInfoState extends State<MoviesInfo> {

  bool showSearchBar = false;
  late YoutubePlayerController _controller;
    bool _isControllerReady = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(trailerUrls[widget.movie.title].toString()) ?? '',
      params:  YoutubePlayerParams(
        
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    
    
  }


  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
      double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 56, 56),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor:  const Color.fromARGB(255, 57, 56, 56),),
      body: CustomScrollView(
      
        slivers: [
          SliverAppBar(
            
            iconTheme: IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            expandedHeight: 250.0, // Set the height of the SliverAppBar
            flexibleSpace: FlexibleSpaceBar(
              background:  YoutubePlayerScaffold(
              controller: _controller,
              autoFullScreen: true,
      
              builder: (context, player) {
                return player;
              },
            
          ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.movie.title.toString(),style: TextStyle(color: Colors.white),
                     maxLines: 1,
                                    overflow: TextOverflow.ellipsis,),
                                                       Wrap(
                      spacing: 8,
                      children: movie.genre!.map((genre) {
                        return Chip(
                          color: MaterialStateProperty.all(Colors.grey),
                          label: Text(genre),
                        );
                      }).toList(),
                    ),

                   Row(
                                children: [
                                       Text(movie.year.toString(),style: TextStyle(
                                        color: Colors.white
                                       ),),
                                       SizedBox(width: width*.03,),
                                  Text(
                                    widget.movie.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                  fontSize: 14
                                    ),
                                 
                                  ),
                             
                                  Icon(Icons.star,color: Colors.yellow,size: 10,),
                                  SizedBox(width: width*.4,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      style: TextButton.styleFrom(backgroundColor: Colors.white,
                                      ),
                                      onPressed: ()async{
                                        Uri url = Uri.parse(widget.movie.website.toString());
                                    try {
                                        await launchUrl(url);
                                      } catch (e) {
                                        print('Error launching URL: $e');
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Failed to open URL: $e')),
                                        );
                                      }}, child: Row(
                                      children: [Icon(Icons.play_arrow),SizedBox(width: width*.02,), Text("Watch Now",style: TextStyle(color: Colors.black),)],
                                    )),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: ()async{
                                await launchUrl(Uri.parse(movie.trailer.toString()));
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.tv,color: Colors.white,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Trailer",style: TextStyle(color: Colors.white),),
                                    ),
                                    SizedBox(width: width*.12,),
                                    Text("laguages: ${movie.language}",style: TextStyle(color: Colors.white)),
                                         SizedBox(width: width*.12,),
                                     Row(children: [
                                Icon(Icons.timelapse,color: Colors.white,),
                                SizedBox(width: 5,),
                                 Text("${movie.runtime.toString()} min",style: TextStyle(color: Colors.blue),),
                              
                                
                              ],)
                                    
                                  ],
                                ),
                              ),
                           
                              Text(movie.plot.toString(),style: TextStyle(color: Color.fromARGB(255, 171, 163, 163)),),
                                 SizedBox(height: height*.01,),

                              Row(children: [
                                Text("Actors:",style: TextStyle(color: Colors.white),),
                                Expanded(
                                  child: Wrap
                                  (
                                    spacing: 8,
                                    children: movie.actors!.map((actor){
                                    return Text("#$actor",style: TextStyle(color: Colors.blue), overflow: TextOverflow.ellipsis);
                                  }).toList()),
                                )
                              ],),
                               Row(children: [
                                Text("Directors:",style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                 Text("#${movie.director.toString()}",style: TextStyle(color: Colors.blue),),
                              
                                
                              ],),
                               Row(children: [
                                Text("Production:",style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                 Text("#${movie.production.toString()}",style: TextStyle(color: Colors.blue),),
                              
                                
                              ],),
                                Row(children: [
                                Text("BoxOffice:",style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                 Text("${movie.boxOffice.toString()}",style: TextStyle(color: Colors.green),),
                              
                                
                              ],)

                ],
              ),
            ),
          )
        
        ],
      ),
    );
  }
}
