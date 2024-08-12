import 'package:flutter/material.dart';

import 'data_class.dart';
class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key,required this.menuOptions});
  final List menuOptions;

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final _popupMenu = GlobalKey<PopupMenuButtonState>();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
        key: _popupMenu,
        child: FloatingActionButton(
          onPressed:(){ _popupMenu.currentState?.showButtonMenu();},
          heroTag: 'btn1',
          backgroundColor: Colors.blueAccent ,
          child: const Icon(Icons.more_vert,color: Colors.white,),
        ),
        onSelected: (value) async {
          listRoutes.add( widget.menuOptions[value][1]);
          await Navigator.pushNamed(context, widget.menuOptions[value][1]);
        },
        itemBuilder: (BuildContext context) => listMenuItem()
    );
  }

  List<PopupMenuItem<int>> listMenuItem(){
    List<PopupMenuItem<int>> result =[];
    for(int i=0,c=widget.menuOptions.length;i<c;i++)
    {
      result.add(
        PopupMenuItem<int>(
          value: i,
          child: Text(widget.menuOptions[i][0]),
        ),
      );
    }

    return result;
  }

}
