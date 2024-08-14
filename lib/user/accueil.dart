import 'package:flutter/material.dart';
import 'package:projet_plante/components/appbar.dart';
import 'package:projet_plante/components/navbar.dart';
import '../components/data_class.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: const AppbarWidget(),
          bottomNavigationBar: const NavBarWidget(),
      body: FutureBuilder<List<dynamic>>(
        future: DataClass().getTree(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: groupTree.length,
              itemBuilder: (BuildContext context, int index) {
                return lisTreeWidget(groupTree[index]);
              },

            );
          }
          else {
            return const CircularProgressIndicator();
          }
        },
      )

    );
  }

  Widget lisTreeWidget(List list){
    return Container(
      height: 300,
      child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)=>Column(
              children: [
                treeWidget(list[index])
              ],
            ),
            separatorBuilder: (context,index)=>const SizedBox(width: 15,),
            itemCount: list.length,
      ),
    );
  }

  Widget treeWidget(Map<dynamic,dynamic> tree){
    return Container(
      margin: const EdgeInsets.all(10),
      height: 230,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(-3,-3)
          ),

          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(4,4)
          )
        ]
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage(tree['image']),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:20,left: 10,bottom: 10,right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Text(tree['name_one'],style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey.shade700,
                        ),),
                      ),
                      SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Text(tree['name_two'],style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey.shade700,
                        ),),
                      )
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                        colors: listColor,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                  ),
                  child: IconButton(
                    color: Colors.transparent,
                    icon: const Icon(Icons.arrow_forward,color: Colors.white,) ,
                    onPressed: () { Navigator.pushNamed(context, '/infoTree',arguments: tree); },
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



