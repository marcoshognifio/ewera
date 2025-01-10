import 'dart:convert';
import 'package:ewera/components/background-image.dart';
import 'package:flutter/material.dart';
import 'package:ewera/components/components.dart';
import 'package:ewera/components/data_class.dart';
import 'package:http/http.dart' as http;
import '../components/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String error = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'email': emailController.text,
        'password': passwordController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/login");
      final response = await http.post(uri,
          body: jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }
      );
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });
      if (data['message'] == 'succes') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connexion réussie !')),
        );
        accessToken = data['accessToken'];
        refreshToken = data['accessToken'];

        await DatabaseHelper().getUserProfile();
        await Navigator.pushNamed(context, '/welcomeUser');
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
                            Navigator.pushNamed(context, '/inscription');
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
                                  text: "E-mail",
                                  type: "text",
                                  express: RegExp(
                                      r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                                  control: emailController,
                                  required: true,
                                  error: "",
                                  icon: const Icon(Icons.mail)),
            
                              EntryField(
                                  text: "Password",
                                  type: "password",
                                  express: RegExp(r''),
                                  control: passwordController,
                                  required: true,
                                  error: "",
                                  icon: const Icon(Icons.vpn_key_outlined)),
            
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        // Supprime le padding
                                        minimumSize: Size.zero,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgetPassword');
                                      },
                                      child: Text(
                                        'Forgot Password ?', style: TextStyle(
                                        color: Colors.white.withAlpha(200),),
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Button(text: 'Connexion', onTap: () async {
                                await actionFunction();
                              },),
                              SizedBox(
                                width: screenWidth * 0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Vous n'avez pas de compte ?",
                                      style: TextStyle(
                                          fontFamily: 'Roboto-Regular',
                                          color: Colors.white),),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/inscription');
                                        },
                                        child: const Text("S'inscrire",
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Regular',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),)
                                    )
                                  ],
                                ),
                              )
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


