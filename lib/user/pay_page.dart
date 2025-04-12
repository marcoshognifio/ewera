import 'package:flutter/material.dart';
import 'package:ewera/components/data_class.dart';

import '../components/appbar.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Informations de Profile',context),
      body: Padding(
        padding: const EdgeInsets.only(top:20.0),
        child: ListView.builder(
            itemCount: listPay.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = listPay[index];
              return parametreItem(item['name'],item['detail'], item['image'], (){});
            },

        ),
      )
    ) ;
  }

  Widget parametreItem(String title,String detail,String image,VoidCallback onTap){

    return  ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 10,right:15.0),
        child:Image.asset(image,width: 50,)
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
