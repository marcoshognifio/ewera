import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ewera/components/data_class.dart';
import 'package:flutter/material.dart';
import '../components/appbar.dart';
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
  bool isLoading = false;
  String error = "";

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    telephoneController.dispose();
  }

  actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'nom' :usernameController.text,
        'tel': telephoneController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/user/update");
      final response = await http.post(uri,
          body: jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken"
          }
      );

      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });
      if (data['message'] == 'succes') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile modifié avec succès !')),
        );
      }
      else {
        setState(() {
          error = 'Email ou Mot de Passe Incorret';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    usernameController.text = userCurrent['nom'];
    emailController.text = userCurrent['email'];
    telephoneController.text = userCurrent['tel'] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Informations de Profile',context),
      body: Container(
        child: Form(
          key: formKey,
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
                child: Button(text: 'MODIFIER', onTap: actionFunction,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
