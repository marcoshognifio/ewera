import 'package:flutter/material.dart';
import 'package:ewera/components/data_class.dart';

import '../components/components.dart';

class DetailAstuces extends StatefulWidget {
  DetailAstuces({super.key,required this.astuce});
  Map astuce;


  @override
  State<DetailAstuces> createState() => _DetailAstucesState();
}

class _DetailAstucesState extends State<DetailAstuces> {

  List<Widget> listPagesWidget = [];
  int current = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: DatabaseHelper().getRecipesAll(widget.astuce['id'] as int), builder: (BuildContext context,snapshot) {

        if(snapshot.hasData){
          if(listRecipes.isNotEmpty){
            listPagesWidget = listPages(context);
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                    delegate: DetailSliver(astuce: widget.astuce, expandedHeight: 350, roundedContainerHeight: 30,)
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top:10,left:20,right: 20,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 60,
                            width: double.infinity,
                            child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listRecipes.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      width: 80,
                                      height: 45,
                                      decoration:  BoxDecoration(
                                        border: Border.all(color:colorApp ),
                                        color: current == index ? colorApp : Colors.white,
                                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      ),
                                      child: Center(
                                          child: Text(
                                            'Astuce ${index+1}',
                                            style: TextStyle(
                                                fontFamily: 'Roboto-Regular',
                                                color: current == index ? Colors.white : colorApp
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                );

                              },
                            )
                        ),
                        listPagesWidget[current]
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          else {
            return emptyPage("Aucune transaction vers un sous projet n'a été ajoutée", Container());
          }
        }
        else {
          return SizedBox(
              width: 100,
              height: 100,
              child: Center(child: const CircularProgressIndicator()));
        }
      },

      )
    );
  }

  List<Widget> listPages(BuildContext context){
    List<Widget> result = [];
    for(int i=0,c=listRecipes.length;i<c;i++){
      result.add(
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnWidget(context, listRecipes[i],i+1)),
            ),
          );
    }
    return result;
  }

  List<Widget> columnWidget( BuildContext context, Map astuce,int index){

    TextStyle t = const TextStyle(
        fontFamily: 'Roboto-Regular',
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500);

    List<Widget> result = [];


    result.add(
        Padding(
          padding: const EdgeInsets.only(left:10, bottom: 5.0,top: 10),
          child: Text('Ingredients :',
            style: const TextStyle(
                fontFamily: 'Roboto-Regular',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        )
    );
    result.add(
        Padding(
          padding: const EdgeInsets.only(left:20),
          child: Text(astuce['ingredients'],
              style:t
          ),
        )
    );

    result.add(
        SizedBox(height: 20,)
    );

    result.add(
        Padding(
          padding: const EdgeInsets.only(left:10, bottom: 5.0),
          child: Text('Instructions :',
            style: const TextStyle(
                fontFamily: 'Roboto-Regular',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
        )
    );

    List list =  (astuce['instructions'] as String).split('#').where((e) => e.isNotEmpty).toList();
    for(int i=0,a=list.length;i<a;i++){
      result.add(
          ListTile(
            leading: Icon(Icons.brightness_1, size: 10,color: colorApp,),
            title: Text(list[i],style: t,),
          )
      );
    }

    return result;
  }
}







class DetailSliver extends SliverPersistentHeaderDelegate {

  DetailSliver({required this.astuce,required this.expandedHeight,
    required this.roundedContainerHeight,});
  final Map astuce;
  final double roundedContainerHeight;
  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: astuce['name'],
          child: Image.network(
            astuce['image'],
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: roundedContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              )
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override

  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

