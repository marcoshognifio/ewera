import 'package:flutter/material.dart';
import 'package:projet_plante/components/data_class.dart';
import '../components/button.dart';

class DetailTree extends StatelessWidget {
  const DetailTree({super.key,required this.tree});
  final Map tree;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                delegate: DetailSliver(tree: tree, expandedHeight: 350, roundedContainerHeight: 30,)
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top:10,left:20,right: 20,bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnWidget(context),
                ),
              ),
            )
          ],
      ),
    );
  }

  List<Widget> columnWidget( BuildContext context ){

    TextStyle t = const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500);

    List<Widget> result = [];

    result.add(Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(tree['name_one'],
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
    )
    );

    result.add(
      Padding(
        padding: const EdgeInsets.only(left:10, bottom: 10.0),
        child: Text(tree['description'],
            style:t
        ),
      )
    );

    List list = tree['details'];
    for(int i=0,a=list.length;i<a;i++){
      result.add(
        ListTile(
          leading: Icon(Icons.brightness_1, size: 10,color: colorApp,),
          title: Text(list[i],style: t,),
        )
      );
    }
    
    result.add(Button(
        text: 'En Savoir plus',
        onTap: () { Navigator.pushNamed(context, '/welcomeUser'); },));

    return result;
  }
}

class DetailSliver extends SliverPersistentHeaderDelegate {

  DetailSliver({required this.tree,required this.expandedHeight,
    required this.roundedContainerHeight,});
  final Map tree;
  final double roundedContainerHeight;
  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
        children: [
          Hero(
            tag: tree['name_one'],
            child: Image.asset(
               tree['image'],
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


