import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/appbar.dart';
import '../components/data_class.dart';

class ProfitUser extends StatelessWidget {
  ProfitUser({super.key,required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWidget('Profile Utilisateur',context),
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
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text('Paramètre du compte',
                            style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: Colors.black,
                                fontSize: screenWidth*0.05,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth*0.8,
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text('Faites des modifications sur votre compte',
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Colors.black,
                              fontSize: screenWidth*0.05,
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
                                        Navigator.pushNamed(context, '/infoProfit');
                                  }
                              ),
                              parametreItem('Modification Mot de Passe',
                                  'Change ton mot de passe',
                                  Icons.lock,
                                  (){
                                    Navigator.pushNamed(context, '/changePassword');
                                  }

                              ),
                              parametreItem('Methode de Payement', 'Ajoute ton mode de payement',Icons.credit_card,
                                      (){
                                        Navigator.pushNamed(context, '/payPage');
                                      }
                              ),
                              parametreItem('Localisation', 'Modifie ton lieux de livraison',Icons.location_on, (){}),

                              parametreItem('Langue',
                                  'Modifie la langue',
                                  FontAwesomeIcons.globe,
                                  (){
                                      Navigator.pushNamed(context, '/changeLanguage');
                                  }
                              ),
                              parametreItem('Aide', 'Condition générale,Mention légale',FontAwesomeIcons.circleQuestion, (){}),

                              const Padding(
                                padding: EdgeInsets.only(top: 10.0,bottom: 30),
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
        padding: EdgeInsets.only(bottom: 10),
        child: Icon(icon, size: screenWidth*0.05,color: Colors.black,),
      ),
      title: Text(title,style: TextStyle(
        fontFamily: 'Roboto-Regular',
        fontWeight: FontWeight.bold,
        fontSize: screenWidth*0.04
      ),),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          border:  Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:10),
          child: Text(detail,style: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: screenWidth*0.038,
              color: Colors.grey
          ),),
        ),
      ),
      onTap: onTap,
    );
  }

}
