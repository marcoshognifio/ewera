import 'package:flutter/material.dart';
import 'package:ewera/user/pay_page.dart';
import '../components/button.dart';
import '../components/data_class.dart';

class DetailTisane extends StatelessWidget {
  const DetailTisane({super.key,required this.tisane});
  final Map<dynamic,dynamic> tisane;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: DetailSliver(tisane: tisane, expandedHeight: 350, roundedContainerHeight: 30,)
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
      padding: const EdgeInsets.only(bottom: 10.0,left: 10, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(tisane['name'],
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Text("${tisane['price']} €",
            style: TextStyle(
                color: colorApp,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    )
    );

    result.add(
        Padding(
          padding: const EdgeInsets.only(left:10, bottom: 10.0),
          child: Text(tisane['description'],
              style:t
          ),
        )
    );

    result.add(Button(
      text: 'Acheter',
      onTap:() {
        Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder:(context, animation, secondAnimation)=> const PayPage(),
              transitionsBuilder: (context, animation, secondAnimation,child) {
                var begin=const Offset(1.0, 0.0);
                var end=const Offset(0.0, 0.0);
                var tween=Tween(begin: begin,end:end);
                return  SlideTransition(position: animation.drive((tween)),child: child);
              }
            )
        );
      }
    ));
    return result;
  }
}

class DetailSliver extends SliverPersistentHeaderDelegate {

  DetailSliver({required this.tisane,required this.expandedHeight,
    required this.roundedContainerHeight,});
  final Map tisane;
  final double roundedContainerHeight;
  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: tisane['name'],
          child: Image.network(
            tisane['image'],
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
