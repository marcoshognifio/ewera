import 'dart:io';
import 'package:ewera/astuces/detail_astuces.dart';
import 'package:ewera/test/test.dart';
import 'package:ewera/tisanes/infos_tisane.dart';
import 'package:ewera/user/change_language.dart';
import 'package:ewera/user/change_password.dart';
import 'package:ewera/user/infos_profit.dart';
import 'package:ewera/user/login.dart';
import 'package:ewera/user/pay_page.dart';
import 'package:ewera/user/profit_user.dart';
import 'package:ewera/user/screen_camera/result_screen.dart';
import 'package:ewera/user/subscription.dart';
import 'package:flutter/material.dart';
import 'package:ewera/Welcome/welcome_slide.dart';
import 'package:ewera/plantes/infos_plante.dart';
import 'package:ewera/user/change_password_forget.dart';
import 'package:ewera/user/email_confirm.dart';
import 'package:ewera/user/forget_password.dart';
import 'package:ewera/user/inscription.dart';
import 'package:ewera/user/user_slide_widgets.dart';
import 'package:flutter/services.dart';
import 'Welcome/welcome_page.dart';
import 'components/data_class.dart';


void main() {
  runApp(MyApp() );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Finance True App',
      onGenerateRoute:(settings)=>RouteGenerator.generatorRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', //'/home',
    );
  }
}

class RouteGenerator {
  static Route<dynamic> ?generatorRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/home':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const WelcomePage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(0.0, 1.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/login':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const LoginPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=settings.arguments as  Offset;
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/inscription':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
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
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> UserSlideWidget(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/confirmEmail':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=>  EmailConfirmationPage(data: settings.arguments as Map<String,dynamic>),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/forgetPassword':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const ForgetPassword(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/changeForgetPassword':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds:during),
            pageBuilder:(context, animation, secondAnimation)=> const ChangePasswordForget(),
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

      case '/infoTisane':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> DetailTisane(tisane: settings.arguments as Map),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoAstuce':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> DetailAstuces(astuce: settings.arguments as Map),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/profileUser':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ProfitUser(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/infoProfit':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> InfoProfit(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/profileUser':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ProfitUser(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/changePassword':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ChangePassword(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/changeLanguage':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ChangeLanguage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/abonnement':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> Subscription(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/payPage':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> const PayPage(),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            });

      case '/screenResult':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: during),
            pageBuilder:(context, animation, secondAnimation)=> ScreenResult(image: settings.arguments as  File,),
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
