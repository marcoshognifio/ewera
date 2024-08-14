import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projet_plante/components/data_class.dart';

import 'components.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 10,
        iconSize: 25,
        unselectedItemColor: const Color(0xFF4D514D),
        unselectedLabelStyle: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),
        selectedLabelStyle: TextStyle(color:colorApp ,fontSize: 15,fontWeight: FontWeight.w700) ,
        selectedItemColor: colorApp,
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
              activeIcon: GradientIcon(
                icon: Icons.home_filled,
                size: 25.0,
                gradient: LinearGradient(
                  colors: listColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              icon: const Icon(Icons.home_filled),// Icon(),
              label: 'Accueil'
          ),

          BottomNavigationBarItem(
              activeIcon: GradientIcon(
                icon: FontAwesomeIcons.seedling,
                size: 25.0,
                gradient: LinearGradient(
                  colors: listColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              icon: const Icon(FontAwesomeIcons.seedling),
              label: 'Plantes'
          ),

          BottomNavigationBarItem(
              label: '',
              activeIcon: GradientIcon(
                icon: Icons.center_focus_weak_rounded,
                size: 25.0,
                gradient: LinearGradient(
                  colors: listColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              icon: const Icon(Icons.center_focus_weak_rounded),
          ),

          BottomNavigationBarItem(
            activeIcon: GradientIcon(
              icon: Icons.sunny,
              size: 25.0,
              gradient: LinearGradient(
                colors: listColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
              icon: const Icon(Icons.sunny),
              label: 'Astuces'
          ),

          BottomNavigationBarItem(
              activeIcon:GradientIcon(
                icon: FontAwesomeIcons.mugHot,
                size: 25.0,
                gradient: LinearGradient(
                  colors: listColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ) ,
              icon: const Icon(FontAwesomeIcons.mugHot),
              label: 'Tisanes'
          ),
        ]
    );
    
  }
}
