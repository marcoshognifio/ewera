import 'package:flutter/material.dart';
import 'package:ewera/components/button.dart';
import 'package:ewera/components/components.dart';

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

                ],
              ),
        ),
    );
  }
}
