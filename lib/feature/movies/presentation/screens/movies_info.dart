import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviesInfo extends StatefulWidget {
  final MoviesModel movie;
  const MoviesInfo({super.key, required this.movie});

  @override
  State<MoviesInfo> createState() => _MoviesInfoState();
}

class _MoviesInfoState extends State<MoviesInfo> {
  MoviesModel mockMovie = MoviesModel(
    id: 4,
    movie: "Pulp Fiction",
    rating: 8.9,
    image: "images/pulp_fiction.jpg",
    imdbUrl: "https://www.imdb.com/title/tt0110912/"
  );
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 56, 56),
      appBar: AppBar(backgroundColor:  const Color.fromARGB(255, 57, 56, 56),),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            automaticallyImplyLeading: false,
            expandedHeight: 250.0, // Set the height of the SliverAppBar
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.movie.image.toString(),
                placeholder: (context, url) => Image.network(
                  "https://i.ytimg.com/vi/GV3HUDMQ-F8/hqdefault.jpg",
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.network(
                  "https://i.ytimg.com/vi/GV3HUDMQ-F8/hqdefault.jpg",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.movie.movie.toString(),style: TextStyle(color: Colors.white),),
                   Row(
                                children: [
                                  Text(
                                    widget.movie.rating.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                  fontSize: 14
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(Icons.star,color: Colors.yellow,size: 10,),
                                  SizedBox(width: width*.5,),
                                  TextButton(
                                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                                    onPressed: ()async{
                                      Uri url = Uri.parse(widget.movie.imdbUrl.toString());
try {
    await launchUrl(url);
  } catch (e) {
    print('Error launching URL: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to open URL: $e')),
    );
  }}, child: Row(
                                    children: [Icon(Icons.play_arrow),SizedBox(width: width*.02,), Text("Watch Now",style: TextStyle(color: Colors.black),)],
                                  ))
                                ],
                              ),
                ],
              ),
            ),
          )
        
        ],
      ),
    );
  }
}
