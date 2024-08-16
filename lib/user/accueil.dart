import 'package:flutter/material.dart';
import 'package:projet_plante/components/button.dart';
import 'package:projet_plante/components/components.dart';

class WelcomeUser extends StatefulWidget {
  const WelcomeUser({super.key});

  @override
  State<WelcomeUser> createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color:  Colors.yellow,
                    width: 350,
                    child: EntrySearch(text: 'Rechecher une plante/Maladie'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ButtonIcon(
                        onTap: (){},
                        icon: const Icon(Icons.search,color: Colors.white,),
                        size: 50,
                    ),
                  )
                ],
              ),
        ),
    );
  }
}
