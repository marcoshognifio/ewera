import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import '../components/data_class.dart';

class DetailTisane extends StatefulWidget {
  const DetailTisane({super.key,required this.tisane});
  final Map<dynamic,dynamic> tisane;

  @override
  State<DetailTisane> createState() => _DetailTisaneState();
}

class _DetailTisaneState extends State<DetailTisane> {

  actionFunction()async {

      Navigator.pushNamed(context, '/abonnement');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Informations sur la tisane',context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: DetailSliver(tisane: widget.tisane, expandedHeight: 350, roundedContainerHeight: 30,)
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
            child: Text(widget.tisane['name'],
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Text("${widget.tisane['price']} €",
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
          child: Text(widget.tisane['description'],
              style:t
          ),
        )
    );

    result.add(Center(
      child: Button(
        text: 'Acheter',
        onTap: actionFunction
      ),
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
