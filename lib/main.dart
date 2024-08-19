import 'package:flutter/material.dart';
import 'package:projet_plante/Welcome/welcome_slide.dart';
import 'package:projet_plante/plantes/infos_plante.dart';
import 'package:projet_plante/user/inscription.dart';
import 'package:projet_plante/user/login.dart';
import 'package:projet_plante/user/user_silde_widgets.dart';

import 'Welcome/welcome_page.dart';


void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Finance True App',
      onGenerateRoute:(settings)=>RouteGenerator.generatorRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
    );
  }
}

class RouteGenerator {
  static Route<dynamic> ?generatorRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/home':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const WelcomePage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/login':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const LoginPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=settings.arguments as  Offset;
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/inscription':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=>const InscriptionPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/welcomeSlide':
        return PageRouteBuilder(

            pageBuilder: (context, animation, secondAnimation) =>
            WelcomeSlide(),
            transitionsBuilder: (context, animation, secondAnimation, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              return FadeTransition(opacity: animation, child: child);
            }
        );


      case '/welcomeUser':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> UserSlideWidgets(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoTree':
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> DetailTree(tree: settings.arguments as Map),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });



    }
    return null;
  }
}
