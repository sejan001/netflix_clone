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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(fetchMovies());
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
            title: Text(
              "Movies",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            floating: true,
            actions: [
              IconButton(
                onPressed: () {
                  context.push("/search");
             
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
                      final movie = state.movies[index];
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
      backgroundColor: Color.fromARGB(255, 50, 49, 49),
    );
  }
}
