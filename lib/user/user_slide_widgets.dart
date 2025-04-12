import 'package:ewera/user/subscription.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../astuces/astuces.dart';
import '../components/appbar.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import '../plantes/plantes.dart';
import 'screen_camera/screen_camera.dart';
import '../tisanes/tisanes.dart';
import 'accueil.dart';
class UserSlideWidget extends StatefulWidget {
  UserSlideWidget({super.key});
  CounterPage  counterPage = CounterPage(0);
  @override
  State<UserSlideWidget> createState() => _UserSlideWidgetState();
}

class _UserSlideWidgetState extends State<UserSlideWidget> {

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarParent(context),
      body: IndexedStack(
        index: widget.counterPage.value,
        children: [
          const WelcomeUser(),
          Trees(contextParent: context,),
          const ScreenCamera(),
          Astuces(contextParent: context,),
          Tisanes(contextParent: context,),
        ],
      ),
      bottomNavigationBar: navbar(),
    );
  }

  Widget navbar() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                2.0,
                2.0,
              ), //Offset
              blurRadius: 2.0,
              spreadRadius: 0.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0),
              blurRadius: 2.0,
              spreadRadius: 0.0,
            )
          ]
      ),
      child: BottomNavigationBar(
          currentIndex: widget.counterPage.value,
          onTap: (int newIndex) {
            setState(() {
              widget.counterPage.value = newIndex;
            });
            viewPageWidget();
          },
          elevation: 10,
          iconSize: 25,
          unselectedItemColor: const Color(0xFF4D514D),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Roboto-Regular',
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300),
          selectedLabelStyle: TextStyle(fontFamily: 'Roboto-Regular',
              color: colorApp,
              fontSize: 10,
              fontWeight: FontWeight.w300),
          selectedItemColor: colorApp,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: Icons.home_filled),
                icon: const Icon(Icons.home_filled), // Icon(),
                label: 'Accueil'
            ),

            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: FontAwesomeIcons.seedling),
                icon: const Icon(FontAwesomeIcons.seedling),
                label: 'Plantes'
            ),

            BottomNavigationBarItem(
              label: '',
              activeIcon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: listColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Icon(
                  Icons.center_focus_strong_rounded, color: Colors.white,),
              ),
              icon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.center_focus_strong_rounded),
              ),
            ),

            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: Icons.sunny),
                icon: const Icon(Icons.sunny),
                label: 'Astuces'
            ),

            BottomNavigationBarItem(
                activeIcon: GradientIcon(icon: FontAwesomeIcons.mugHot,),
                icon: const Icon(FontAwesomeIcons.mugHot),
                label: 'Tisanes'
            ),
          ]
      ),
    );
  }


  void viewPageWidget() {
    setState(() {
      widget.counterPage.value = widget.counterPage.value;
    });
  }
}


class MyFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = (scaffoldGeometry.scaffoldSize.width - 50) / 2; // Centré horizontalement
    final double y = scaffoldGeometry.scaffoldSize.height - 80; // Position verticale (ajustez selon votre besoin)
    return Offset(x, y); // Positionnement absolu
  }
}


