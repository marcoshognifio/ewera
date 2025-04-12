import 'package:flutter/material.dart';

import '../components/appbar.dart';
import '../components/button.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {

  final List<String> texts = [
    "Un lien d'Affiliation",
    "Une interface",
    "Jus de noni fruité",
    "2 paires de savons de gommage ou le vin de noni"
  ];
  List<bool> isChecked = [false, false, false, false];

  void onChanged(bool? value, int index) {
    setState(() {
      isChecked[index] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Abonnez-Vous',context),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  Expanded(child: Text('Ewéra Prémium',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ))),
                  Icon(Icons.diamond_outlined,size: 30,),
                ],
              ),

            SizedBox(height: 10,),

            Text('\$ 60',style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),),

            SizedBox(
              height: 10,
            ),

            Text("La pack d'affilé vous permet non seuelement d'etre affilé mais vous offre aussi des avantages",
              style: TextStyle(
                  fontSize: 13,
                color: Colors.grey,
                height: 1.5
              ),
            ),

            SizedBox(
              height: 20,
            ),

            SizedBox(
              height:260,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        isChecked[index] = !isChecked[index];
                      });
                    },
                    leading: GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked[index] = !isChecked[index];
                        });
                      },
                      child: Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isChecked[index]
                              ? Icons.check_rounded
                              : Icons.circle,
                          color: isChecked[index] ? Colors.black : Colors.grey.shade300,
                          size: 20,
                        ),
                      ),
                    ),
                    title: Text(texts[index]),
                  );
                },
              ),
            ),

            Center(child: Button(text: 'SOUSCRIRE', onTap: (){})),
          ],
        ),
      ),
    );
  }
}
