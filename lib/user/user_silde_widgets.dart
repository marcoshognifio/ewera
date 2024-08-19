import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projet_plante/components/appbar.dart';
import 'package:projet_plante/user/accueil.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import '../plantes/plantes.dart';

class UserSlideWidgets extends StatefulWidget {
  UserSlideWidgets({super.key});

  CounterPage  counterPage = CounterPage(0);

  final controller = PageController();
  final List<Widget> bodies =[
    const WelcomeUser(),
    const Trees(),
    Container()
  ];

  @override
  State<UserSlideWidgets> createState() => _UserSlideWidgetsState();
}

class _UserSlideWidgetsState extends State<UserSlideWidgets> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: const AppbarWidget(),
        backgroundColor: Colors.white,
        body:PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.controller,
          children: widget.bodies,
        ),
        bottomNavigationBar: navbar(),
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

            widget.controller.animateToPage(
              widget.counterPage.value,
              duration:const Duration(milliseconds: 300),
              curve: Curves.easeInOut,);
          },
          elevation: 10,
          iconSize: 25,
          unselectedItemColor: const Color(0xFF4D514D),
          unselectedLabelStyle: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),
          selectedLabelStyle: TextStyle(color:colorApp ,fontSize: 15,fontWeight: FontWeight.w700) ,
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
}


