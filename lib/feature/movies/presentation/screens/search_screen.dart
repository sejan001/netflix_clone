import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_movies/feature/movies/data/models/movies_model.dart';
import 'package:project_movies/feature/movies/presentation/bloc/movies_bloc/bloc/movies_bloc.dart';


class SearchScreen extends StatefulWidget {
  final List< MoviesModel> movies;
  const SearchScreen({super.key, required this.movies});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchMovies = TextEditingController();
  List<MoviesModel> searchedMovies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     BlocProvider.of<MoviesBloc>(context).add(fetchMovies());
  }
 void searchMovies() {
    final name = _searchMovies.text.toLowerCase();
    
   Timer(Duration(seconds: 1), (){
  
     setState(() {
  
  searchedMovies = widget.movies.where((movie) {
        return movie.movie!.toLowerCase().startsWith(name);
      }).toList();
    });
   });
  }
  
  @override
  Widget build(BuildContext context) {
       double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return CustomScrollView(
      slivers: [
        SliverAppBar(backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            title: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      
                      onChanged: (value){
                        Center(child: CircularProgressIndicator(),);
                    searchMovies();
                      },
                      controller: _searchMovies,
                      decoration: InputDecoration(
                         contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red))
                      ),
                    ),
                  ),
                    IconButton(onPressed: (){
                      searchMovies();
                    }, icon: Icon(Icons.search))
                ],
              ),
            ),
            
          ),
        ),
        
             
                 SliverGrid(
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (width / height) * 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                     
                      final movie = searchedMovies[index];
                      return GestureDetector(
                        onTap: (){
                          context.push("/moviesInfo",extra: movie);
                        },
                        child: Container(
                          
                          decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.white)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: movie.image.toString(),
                                    placeholder: (context, url) =>  Image.network("https://i.pinimg.com/736x/7f/9f/6b/7f9f6b4b5cc2de478502a18b823eb15a.jpg",fit: BoxFit.cover,),
                                    errorWidget: (context, url, error) => Image.network("https://i.pinimg.com/736x/7f/9f/6b/7f9f6b4b5cc2de478502a18b823eb15a.jpg",fit: BoxFit.cover,),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  movie.movie.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      movie.rating.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                    fontSize: 10
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(Icons.star,color: Colors.yellow,size: 10,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: searchedMovies.length,
                  ),
                )]
    );
             
            }
          
 
        
    

}