import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class Astuces extends StatelessWidget {
  const Astuces({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (context){
                return FutureBuilder<List<dynamic>>(
                  future: DataClass().getTree(),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if(snapshot.hasData){
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: Column(
                            children:[
                              EntrySearch(text: 'Rechecher une plante/Maladie'),
                              Card(
                                child: Column(
                                  children: columnItemWidget(groupTree, context),
                                ),
                              )
                            ] ,
                          ),
                        ),
                      );
                    }
                    else {
                      return const CircularProgressIndicator();
                    }
                  },
                );
              }
          );
        }
    );
  }

  List<Widget> columnItemWidget(List list,BuildContext context){
    List<Widget> result =[];

    for(int i=0,c=list.length;i<c;i++){

      result.add(
          lisTreeWidget(groupTree[i],context)
      );
    }
    return result;
  }

  Widget lisTreeWidget(List list,BuildContext context){

    return Container(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Column(
          children: [
            treeWidget(list[index],context)
          ],
        ),
        separatorBuilder: (context,index)=>const SizedBox(width: 15,),
        itemCount: list.length,
      ),
    );
  }

  Widget treeWidget(Map<dynamic,dynamic> tree , BuildContext context){

    return Container(
      margin: const EdgeInsets.all(10),
      height: 250,
      width: 175,
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
            height: 175,
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
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),),
                      ),
                      SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Text(tree['name_two'],style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),),
                      )
                    ],
                  ),
                ),
                ButtonIcon(
                  onTap: (){
                    Navigator.of(context).push(
                        PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder:(context, animation, secondAnimation)=> DetailTree(tree: tree),
                            transitionsBuilder: (context, animation, secondAnimation,child) {
                              var begin=const Offset(1.0, 0.0);
                              var end=const Offset(0.0, 0.0);
                              var tween=Tween(begin: begin,end:end);
                              return  SlideTransition(position: animation.drive((tween)),child: child);
                            }
                        )
                    );
                  },
                  icon:  const Icon(Icons.arrow_forward,color: Colors.white,),
                  size: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
