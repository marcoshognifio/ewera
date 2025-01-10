import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ewera/user/profit_user.dart';
import '../astuces/astuces.dart';
import '../components/appbar.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import '../plantes/plantes.dart';
import '../tisanes/tisanes.dart';
import 'accueil.dart';

class UserSlideWidget extends StatefulWidget {
  UserSlideWidget({super.key});
  CounterPage  counterPage = CounterPage(0);
  final navigatorKey = GlobalKey<NavigatorState>();
  ChangeAppBar notifier = ChangeAppBar(Container());

  @override
  State<UserSlideWidget> createState() => _UserSlideWidgetState();
}

class _UserSlideWidgetState extends State<UserSlideWidget> {


  @override
  void initState() {
    widget.notifier = ChangeAppBar(appBarParent());
    super.initState();
  }




  final controller = PageController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppbarWidget(
        notifier: widget.notifier
      ),
      body: Navigator(
        key: widget.navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/':
              return MaterialPageRoute(builder: (context) => const WelcomeUser());
            case '/trees':

              return MaterialPageRoute(builder: (context) =>const Trees());

            case '/astuces':
              return MaterialPageRoute(builder: (context) =>const Astuces());

            case '/tisanes':
              return MaterialPageRoute(builder: (context) =>const Tisanes());

            case '/profileUser':

              Widget parent = widget.notifier.appBar;
              setState(() {
                widget.notifier.appBar = appBarWidget('Profile Utilisateur',widget.notifier,parent,widget.navigatorKey);
              });
              return MaterialPageRoute(builder: (context) =>ProfitUser(navigatorKey: widget.navigatorKey, notifier: widget.notifier, appBarParent: parent,));
          }
          return null;
        },
      ),
      bottomNavigationBar: navbar(),
    );
  }

  Widget appBarParent(){
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.white,
      leading:  Center(child: Image.asset('assets/images/Ewera.png',width: 70,color: colorApp,)),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.account_circle_rounded,size: 50,color:Color(0xFF236718),),
          onPressed: (){
            widget.navigatorKey.currentState?.pushNamed('/profileUser');
          },
        ),
      ],

    );
  }


  Widget navbar() {
    return Container(
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
      child: BottomNavigationBar(
          currentIndex: widget.counterPage.value,
          onTap: (int newIndex){
            setState(() {
              widget.counterPage.value = newIndex;
            });
            viewPageWidget();
          },
          elevation: 10,
          iconSize: 25,
          unselectedItemColor: const Color(0xFF4D514D),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),
          selectedLabelStyle: TextStyle(fontFamily: 'Roboto-Regular',color:colorApp ,fontSize: 15,fontWeight: FontWeight.w700) ,
          selectedItemColor: colorApp,
          type: BottomNavigationBarType.fixed,
          items:  [
            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: Icons.home_filled),
                icon: const Icon(Icons.home_filled),// Icon(),
                label: 'Accueil'
            ),

            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: FontAwesomeIcons.seedling),
                icon: const Icon(FontAwesomeIcons.seedling),
                label: 'Plantes'
            ),

            BottomNavigationBarItem(
              label: '',
              activeIcon: GradientIcon(
                icon: Icons.center_focus_weak_rounded,
              ),
              icon: const Icon(Icons.center_focus_weak_rounded),
            ),

            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: Icons.sunny),
                icon: const Icon(Icons.sunny),
                label: 'Astuces'
            ),

            BottomNavigationBarItem(
                activeIcon:GradientIcon(icon: FontAwesomeIcons.mugHot,) ,
                icon: const Icon(FontAwesomeIcons.mugHot),
                label: 'Tisanes'
            ),
          ]
      ),
    );
  }



  void viewPageWidget(){
    switch (widget.counterPage.value) {
      case 0: widget.navigatorKey.currentState?.pushNamed('/');
      case 1: widget.navigatorKey.currentState?.pushNamed('/trees');
      case 2: widget.navigatorKey.currentState?.pushNamed('/trees');
      case 3: widget.navigatorKey.currentState?.pushNamed('/astuces');
      case 4: widget.navigatorKey.currentState?.pushNamed('/tisanes');
    }
  }
}





