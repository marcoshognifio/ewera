import 'package:ewera/components/data_class.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/components.dart';

class InfoProfit extends StatefulWidget {
  const InfoProfit({super.key});

  @override
  State<InfoProfit> createState() => _InfoProfitState();
}

class _InfoProfitState extends State<InfoProfit> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final telephoneController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    telephoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    usernameController.text = userCurrent['nom'];
    emailController.text = userCurrent['email'];
    telephoneController.text = "+229 55 666 222";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            EntryFieldEdit(
                text: "NOM & PRENOM",
                type: "text",
                express: RegExp(r'^[a-zA-Z]+( )?[a-zA-Z]+$'),
                control: usernameController,
                required: true,
                error: "",
            ),

            EntryFieldEdit(
                text: "EMAIL",
                type: "text",
                express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                control: emailController,
                required: true,
                error: "",
            ),

            EntryFieldEdit(
                text: "NUMERO",
                type: "text",
                express: RegExp(r''),
                control: telephoneController,
                required: true,
                error: "",
            ),

            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Button(text: 'MODIFIER', onTap: () {  },),
            )
          ],
        ),
      ),
    );
  }
}
