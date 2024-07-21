import 'package:flutter/material.dart';
import 'package:project_movies/feature/movies/data/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 54, 54),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor:  const Color.fromARGB(255, 58, 54, 54) ,),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text("Who's Watching",style: TextStyle(color: Colors.white,fontSize: 30
                ,fontWeight: FontWeight.w500),),
                SizedBox(height: height*.1,),
                Container(
                  height: height*.2,
                  width: width*.4,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: widget.user.image != null? NetworkImage(widget.user.image.toString()) : AssetImage("lib/assets/images/pp.jpg"),fit: BoxFit.cover )
                  ),
                ),
                 Text("@${widget.user.username}",style: TextStyle(color: Colors.white,fontSize: 20
                ,fontWeight: FontWeight.w500),),            SizedBox(height: height*.03,),
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey)
  ),
  child:  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text("Manage Profiles",style: TextStyle(color: Color.fromARGB(255, 199, 181, 181),fontSize: 18
                  ,fontWeight: FontWeight.w300),),
  ),
)
              ],
            ),
          )
        ],
      ),
    );
  }
}