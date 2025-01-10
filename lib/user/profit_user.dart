import 'package:ewera/user/change_language.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ewera/user/infos_profit.dart';
import '../components/appbar.dart';
import 'change_password.dart';

class ProfitUser extends StatelessWidget {
  ProfitUser({super.key,required this.navigatorKey,required this.notifier,required this.appBarParent});
  GlobalKey<NavigatorState> navigatorKey;
  ChangeAppBar notifier;
  Widget appBarParent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
              children:[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top:15.0,left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: const Text('Paramètre du compte',
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 22),
                          child: const Text('Faites des modifications sur votre compte',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              parametreItem(
                                  'Information de Profile',
                                  'Change les informations du compte',
                                  FontAwesomeIcons.user,
                                      (){
                                    Widget parent = notifier.appBar;
                                    notifier.appBar = appBarWidget('Information de Profile',notifier,parent,navigatorKey);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>const InfoProfit()
                                        )
                                    );
                                  }
                              ),
                              parametreItem('Modification Mot de Passe',
                                  'Change ton mot de passe',
                                  Icons.lock,
                                  (){
                                    Widget parent = notifier.appBar;
                                    notifier.appBar = appBarWidget('Modification Mot de Passe',notifier,parent,navigatorKey);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>const ChangePassword()
                                        )
                                    );
                                  }

                              ),
                              parametreItem('Methode de Payement', 'Ajoute ton mode de payement',Icons.credit_card, (){}),
                              parametreItem('Localisation', 'Modifie ton lieux de livraison',Icons.location_on, (){}),

                              parametreItem('Langue',
                                  'Modifie la langue',
                                  FontAwesomeIcons.globe,
                                      (){
                                    Widget parent = notifier.appBar;
                                    notifier.appBar = appBarWidget('Modification La Langue',notifier,parent,navigatorKey);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>const ChangeLanguage()
                                        )
                                    );
                                  }
                              ),
                              parametreItem('Aide', 'Condition générale,Mention légale',FontAwesomeIcons.user, (){}),

                              const Padding(
                                padding: EdgeInsets.only(top: 30.0,bottom: 30),
                                child: Text('from\nH-KIM',style: TextStyle(fontFamily: 'Roboto-Regular',),),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ]
          ),
        )
    );
  }


  Widget parametreItem(String title,String detail,IconData icon,VoidCallback onTap){

    return  ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10,right:15.0),
        child: Icon(icon, size: 25,color: Colors.black,),
      ),
      title: Text(title,style: const TextStyle(
        fontFamily: 'Roboto-Regular',
        fontWeight: FontWeight.bold,
        fontSize: 17
      ),),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          border:  Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Text(detail,style: const TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 15,
            color: Colors.grey
        ),),
      ),
      onTap: onTap,
    );
  }

}
