import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppbarWidget({super.key,required this.notifier});
  ChangeAppBar notifier;

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (BuildContext context)=>notifier,
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  3.0,
                  3.0,
                ), //Offset
                blurRadius: 3.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Color(0xff363636),
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
              )
            ]
        ),
        child: Consumer<ChangeAppBar>(
            builder:(context,notifier,_)=>notifier.appBar
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class ChangeAppBar with ChangeNotifier {
  Widget _appBar;
  ChangeAppBar(this._appBar);
  Widget get appBar=>_appBar;
  set appBar(Widget newBar){
    _appBar = newBar;
    notifyListeners();
  }
}

Widget appBarWidget(String title, ChangeAppBar notifier, Widget appBarParent,GlobalKey<NavigatorState> navigatorKey){

  return AppBar(
    title: Center(
      child: Text(title,
        style: const TextStyle(
            fontFamily: 'Roboto-Regular',
            color: Colors.black
        ),
      ),
    ),
    leading: IconButton(
        onPressed: (){
          notifier.appBar = appBarParent;
          navigatorKey.currentState?.pop();
        },
        icon: const Icon(Icons.arrow_back_ios_rounded,
          color: Colors.black,
        )
    ),
  );
}
