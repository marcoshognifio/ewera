import 'package:flutter/material.dart';

import 'data_class.dart';

AppBar appBarWidget (String title,BuildContext context){
  return AppBar(
    elevation: 3.0,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    title: Text(title,
      style: const TextStyle(
          fontFamily: 'Roboto-Regular',
          color: Colors.black
      ),
    ),
    leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_rounded,
          color: Colors.black,
        )
    ),
  );
}

AppBar appBarParent(BuildContext context){
  return AppBar(
    elevation: 3,
    backgroundColor: Colors.white,
    shadowColor: Colors.black,
    leading:  Center(child: Image.asset('assets/images/Ewera.png',width: 70,color: colorApp,)),
    actions: [
      IconButton(
        color: Colors.white,
        icon: const Icon(Icons.account_circle_rounded,size: 50,color:Color(0xFF236718),),
        onPressed: (){
          Navigator.pushNamed(context, '/profileUser');
        },
      ),
    ],

  );
}


