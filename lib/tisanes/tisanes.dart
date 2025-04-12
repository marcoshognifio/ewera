import 'dart:math';

import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'infos_tisane.dart';
import 'package:flutter/rendering.dart';

class Tisanes extends StatefulWidget {
  Tisanes({super.key,required this.contextParent});
  BuildContext contextParent;

  @override
  State<Tisanes> createState() => _TisanesState();
}

class _TisanesState extends State<Tisanes> {

  int index = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isSearchVisible = true;
  final form = GlobalKey<FormState>();
  final tisaneController = TextEditingController();
  List<List<Map>> _items = [];
  List<List<Map>> groupTisanes = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollSearch);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollSearch);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreItems();
    }
  }

  void _onScrollSearch() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // Défilement vers le bas
      if (_isSearchVisible) {
        setState(() {
          _isSearchVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // Défilement vers le haut
      if (!_isSearchVisible) {
        setState(() {
          _isSearchVisible = true;
        });
      }
    }
  }

  Future<void> _loadMoreItems() async {
    setState(() {
      _isLoading = true;
    });

    // Simuler un délai pour le chargement
    await Future.delayed(const Duration(seconds: 2));

    final newItems = groupTisanes.skip(5+index*5).take(5).toList();
    index++;
    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  Future searchAction() async{
    if (form.currentState!.validate()) {
      await DatabaseHelper().searchTisanes(tisaneController.text);
    }
  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (context){
                  return FutureBuilder<List<dynamic>>(
                    future: DatabaseHelper().getTisanesAll(),
                    builder: (context,snapshot) {

                      if(snapshot.hasData){

                        return ValueListenableBuilder(
                            valueListenable: listTisanesNotifier,
                            builder: (context,list,child){

                              if(listTisanes.isNotEmpty){
                                groupTisanes = Group().getGroupList(listTisanes);
                                _items = groupTisanes.take(5).toList();
                                return Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: _isSearchVisible ? 80.0 : 0.0,
                                      curve: Curves.easeInOut,
                                      child: _isSearchVisible
                                          ? Padding(
                                        padding: const EdgeInsets.only(bottom: 15.0,top: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            EntrySearch(text: 'Rechecher une Tisane', formKey: form, control: tisaneController, onTap: searchAction,),
                                          ],
                                        ),
                                      ): null,
                                    ),
                                    SizedBox(
                                      child: Column(
                                        children: columnItemWidget(_items, context),
                                      ),
                                    )

                                  ],
                                );
                              }
                              else {
                                return  emptyPage("Vide", Container());
                              }
                            }
                        );

                      }
                      else {
                        return SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(child: const CircularProgressIndicator()));
                      }
                    }
                  );
                }
            );
          }
      ),
    );
  }

  List<Widget> columnItemWidget(List list,BuildContext context){
    List<Widget> result =[];

    for(int i=0,c=list.length;i<c;i++){

      result.add(
          lisTreeWidget(list[i],context)
      );
    }
    result.add(

      _isLoading ?const Center(child: CircularProgressIndicator()
      ):Container()
    );
    return result;
  }

  Widget lisTreeWidget(List list,BuildContext context){

    return Container(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Column(
          children: [
            tisaneWidget(list[index],context)
          ],
        ),
        separatorBuilder: (context,index)=>const SizedBox(width: 5,),
        itemCount: list.length,
      ),
    );
  }

  Widget tisaneWidget(Map<dynamic,dynamic> tisane , BuildContext context){

    List photos = tisane['photo'];
    //tisane['price'] = formatter.format(tisane['price']);
    Random random = Random();
    int randomIndex = random.nextInt(photos.length);
    tisane['image'] = '$url/${photos[randomIndex]}';

    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      width: 150,
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
            height: 130,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(tisane["image"]),
                    fit: BoxFit.cover
                )
            )
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
                        child: Text(tisane['name'],style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),),
                      ),
                      SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Text("${tisane['price']} €",style: TextStyle(
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
                    FocusScope.of(context).unfocus();
                    Navigator.of(widget.contextParent).pushNamed('/infoTisane',arguments: tisane);

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
