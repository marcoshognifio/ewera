import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ewera/components/components.dart';
import 'package:ewera/components/data_class.dart';
import 'package:http/http.dart' as http;
import '../components/background-image.dart';
import '../components/button.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionState();
}

class _InscriptionState extends State<InscriptionPage> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String error ="";
  RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{4,}$");
  RegExp usernameRegex = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ\s'-]{3,50}$");
  RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'nom' :usernameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/register");
      final response = await http.post(uri,
          body:jsonEncode(request),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"}
      );
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      setState(() {
        isLoading = false;
      });
      if (data['message'] == 'succes') {
        token = "${data['token']}";
        await Navigator.pushNamed(context, '/confirmEmail',arguments: 'create');
      }
      else {
        if(data['message'] == 'exists'){
          setState(() {
            error = 'Cet email a été déjà utilisé';
          });
        }
        else {
          setState(() {
          error = 'Email ou Mot de Passe Incorret';
        });
        }
      }
    }
  }

  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70,),
                SizedBox(
                  width: screenWidth*0.8,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white
                        ),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_forward_ios, color: colorApp),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login',arguments: const Offset(1, 0));
                          },
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text("Bienvenu sur EWERA",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    wordSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Connectez vous afin de gérer vos projets",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Column(
                    children: [

                      if(error != "")
                        Text(error, style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Roboto',
                            fontSize: screenWidth * 0.04
                        ),),

                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              EntryField(
                                  text: "Username",
                                  type: "text",
                                  express: usernameRegex,
                                  control: usernameController,
                                  required: true,
                                  error: "Nom invalide",
                                  icon: const Icon(Icons.account_circle_sharp)),

                              EntryField(
                                  text: "E-mail",
                                  type: "text",
                                  express: emailRegex,
                                  control: emailController,
                                  required: true,
                                  error: "Entrez un adresse email",
                                  icon: const Icon(Icons.mail)),

                              EntryField(
                                  text: "Password",
                                  type: "password",
                                  express: passwordRegex,
                                  control: passwordController,
                                  required: true,
                                  error: "",
                                  icon: const Icon(Icons.vpn_key_outlined)),

                              EntryField(
                                  text: "Confirmer Password",
                                  type: "password",
                                  express: passwordRegex,
                                  control: confirmPasswordController,
                                  required: true,
                                  error: "",
                                  icon: const Icon(Icons.vpn_key_outlined)),

                              Padding(
                                padding: const EdgeInsets.only(top:  15.0,right: 50),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text('Forgot Password ?',style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Colors.white.withOpacity(0.7),),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Button(text: 'Inscription', onTap: () async{
                                await actionFunction();
                              },)
                            ],
                          )
                      )
                    ],
                  ),
                ),
                if(isLoading )
                  const Align(

                    child: Center(
                        child: CircularProgressIndicator()
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
