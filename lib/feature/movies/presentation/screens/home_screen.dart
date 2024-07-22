import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:project_movies/feature/movies/data/models/user_model.dart';
import 'package:project_movies/feature/movies/domain/services/sharedprefs_services.dart';
import 'package:project_movies/feature/movies/presentation/bloc/movies_bloc/bloc/movies_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String,String> imageUrls= {"The Shawshank Redemption" :"https://i5.walmartimages.com/seo/The-Shawshank-Redemption-DVD-Castle-Rock-Drama_e71b2ff8-1060-47df-b836-98608ca60a0a.2d720e36a9bcf80b3039a41a49f4194e.jpeg",
 "The Godfather": "https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_QL75_UY281_CR4,0,190,281_.jpg",
 "The Dark Knight": "https://preview.redd.it/whatre-ur-thoughts-on-the-dark-knight-is-it-still-the-v0-z19ndjd7m2ac1.jpeg?width=640&crop=smart&auto=webp&s=3c664143924ecfb217ab708407259da6000f9108",
 "Pulp Fiction": "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg",
 "Forrest Gump": "https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg",
 "Inception": "https://m.media-amazon.com/images/M/MV5BMjExMjkwNTQ0Nl5BMl5BanBnXkFtZTcwNTY0OTk1Mw@@._V1_.jpg",
"The Matrix":  "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg",
"The Lord of the Rings: The Return of the King":  'https://upload.wikimedia.org/wikipedia/en/6/65/TROP_season_1_poster.jpg',
 "The Dark Knight Rises": "https://m.media-amazon.com/images/M/MV5BMTk4ODQzNDY3Ml5BMl5BanBnXkFtZTcwODA0NTM4Nw@@._V1_FMjpg_UX1000_.jpg",
 "Interstellar": "https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10543523_p_v8_as.jpg",
"Fight Club":  "https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg",
 "Gladiator" : "https://64.media.tumblr.com/570d31a50500b597ced8bad729e10a0d/07b237cc13407636-19/s500x750/f2ee8c677f80e1899cf9d8979be5a6f8a9a06813.jpg",
  "The Lord of the Rings: The Two Towers" :"https://m.media-amazon.com/images/I/91oZdoyy4TL._AC_UF894,1000_QL80_.jpg",
"The Silence of the Lambs":"https://m.media-amazon.com/images/I/51SHYSFNP2L._AC_UF894,1000_QL80_.jpg",
  "The Departed":"https://play-lh.googleusercontent.com/yOtyaCoWJ2szPrVYTYpbCRAAI9Wov8kMADcxT0mW8wyoOHPYXFMghVwdoGAG1kxXIYBfJw=w240-h480-rw",
  "Saving Private Ryan":"https://cdn.britannica.com/12/66012-050-F8306052/Tom-Hanks-Saving-Private-Ry3an.jpg",
 "The Prestige": "https://images.hive.blog/1200x630/https://files.peakd.com/file/peakd-hive/im-groot/23wgDEwEmuxZtnqsYLWQAX3aGHzFqKXfCvfN16S6XP19h73Nvw8grr7DngmhzCEEzFEHc.jpeg",
  "Glory":"https://www.sonypictures.com/sites/default/files/styles/max_560x840/public/title-key-art/glory_onesheet_1400x2100.png?itok=qZ5Zt07h",
  "The Avengers":"https://cdn.britannica.com/60/182360-050-CD8878D6/Avengers-Age-of-Ultron-Joss-Whedon.jpg",
 "The Lion King" : "https://lumiere-a.akamaihd.net/v1/images/p_thelionking_19752_1_0b9de87b.jpeg"











  };
  bool showSearchBar = false;
    TextEditingController _searchMovies = TextEditingController();
  @override

  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(fetchMovies());
  }
   void searchMovies() {
    final name = _searchMovies.text.toLowerCase();
    
  
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        backgroundColor:  Color.fromARGB(221, 4, 2, 2) ,
        child: SingleChildScrollView(
          child: Column(
            children: [
                
              Container(
                height: height*.2,
                width: width*.55,
                decoration:BoxDecoration(
                  image: DecorationImage(image: AssetImage('lib/assets/images/drawer.png'),fit: BoxFit.cover),
                ),
              ),
              ListTile(
                leading: Icon(Icons.rocket,color: Colors.white,),
                title: Text("Discover",style: TextStyle(color: Colors.white,fontSize: 13),),
              ),
              SizedBox(height: height*.01,),
                ListTile(
                leading: Icon(Icons.movie,color: Colors.white,),
                title: Text("Movies",style: TextStyle(color: Colors.white,fontSize: 13),),
                
          
              ),
                SizedBox(height: height*.01,),
                ListTile(
                leading: Icon(Icons.tv,color: Colors.white,),
                title: Text("TV Shows",style: TextStyle(color: Colors.white,fontSize: 13),),
                
          
              ),
          
                SizedBox(height: height*.01,),
                ListTile(
                leading: Icon(Icons.hd,color: Colors.white,),
                title: Text("HD Releases",style: TextStyle(color: Colors.white,fontSize: 13),),
                
          
              ),
                SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.calendar_month,color: Colors.white,),
              title: Text("Calender",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
              SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.category,color: Colors.white,),
              title: Text("Category",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
            Divider(color: Colors.grey,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("User",style: TextStyle(color: Colors.grey),),
              )),
               SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.collections_bookmark_outlined,color: Colors.white,),
              title: Text("Collections",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
             SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.list,color: Colors.white,),
              title: Text("Watchlist",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
           SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.watch_later_outlined,color: Colors.white,),
              title: Text("Recent",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
             SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.download,color: Colors.white,),
              title: Text("Download Manager",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
              Divider(color: Colors.grey,),
          SizedBox(height: height*.01,),
              ListTile(
              leading: Icon(Icons.settings,color: Colors.white,),
              title: Text("Settings",style: TextStyle(color: Colors.white,fontSize: 13),),
              

            ),
             SizedBox(height: height*.01,),
              GestureDetector(
                onTap: (){
                  SharedPreferenecesService.removeString(key: 'token');
                  SharedPreferenecesService.removeString(key: "saveUser");
                    SharedPreferenecesService.removeString(key: "currentUser");
                  context.go('/');
                },
                child: ListTile(
                leading: Icon(Icons.logout_outlined,color: Colors.white,),
                title: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 13),),
          
                
                            ),
              ),
            ],
          ),
        ),
        
        
        width: width*.55,

      ),
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(221, 4, 2, 2),
            
             flexibleSpace: FlexibleSpaceBar(
            title: !showSearchBar? Text("Movies",style: TextStyle(color: Colors.white),): SafeArea(
              top: true,
              child: Row(
                
                children: [
                  Container(
                    width: width*.5,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      
                      onChanged: (value){
                   BlocProvider.of<MoviesBloc>(context).add(fetchMovies(searchQuery: _searchMovies.text));
                      },
                      controller: _searchMovies,
                      decoration: InputDecoration(
                         contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red))
                      ),
                    ),
                  ),
                                  ],
              ),
            ),
            
          ),
            centerTitle: true,
            floating: true,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                     
 
                      showSearchBar = !showSearchBar;
                      
                    });
             
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    context.push("/profile",extra: widget.user);
                  },
                  child: CircleAvatar(
                    backgroundImage: widget.user.image != null? NetworkImage(widget.user.image.toString()) : AssetImage("lib/assets/images/pp.jpg")
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
             if (state is MoviesLoading) {
  return SliverToBoxAdapter(
    child: Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey[300]!,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: (width / height) * 1.5,
        ),
        itemCount: 50, 
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[800], 
          );
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    ),
  );
}

              if (state is MoviesLoaded) {
                
                return SliverGrid(
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: (width / height) * 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      
                        // movies = state.movies;
                        // print("list ma gayoooo $movies");
                    
                    
                      final movie = state.movies[index];
                      
                      final poster = imageUrls[movie.title];
                      
                      return GestureDetector(
                        onTap: (){
                          context.push("/moviesInfo",extra: movie,);
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
                                    imageUrl: poster.toString(),
                                    placeholder: (context, url) =>  Image.network("https://i.pinimg.com/736x/7f/9f/6b/7f9f6b4b5cc2de478502a18b823eb15a.jpg",fit: BoxFit.cover,),
                                    errorWidget: (context, url, error) => Image.network("https://i.pinimg.com/736x/7f/9f/6b/7f9f6b4b5cc2de478502a18b823eb15a.jpg",fit: BoxFit.cover,),
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                ),
                               
                                Text(
                                  movie.title.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                    childCount: state.movies.length,
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 30, 27, 27),
    );
  }
}
