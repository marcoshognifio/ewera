import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ewera/components/components.dart';
import 'package:ewera/components/data_class.dart';
import 'package:http/http.dart' as http;
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/input_file.dart';

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
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  RegExp usernameRegex = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ\s'-]{3,50}$");
  RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  Map<String, String> messages = {};
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  actionFunction() async {

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
      setState(() {
        isLoading = false;
      });
      print(data);
      if (data['message'] == 'succes') {
        token = "${data['token']}";
        request = {'email':request["email"],'type':'create' };
        await Navigator.pushNamed(context, '/confirmEmail',arguments: request);
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
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth*0.8,
                    height: screenHeight*0.2,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    express: usernameRegex,
                                    control: usernameController,
                                    required: true,
                                    error: "Nom invalide",
                                    icon: const Icon(Icons.account_circle_sharp),
                                    onTap: (){},
                                    validator: (value) {

                                },),

                                EntryField(
                                    text: "E-mail",
                                    express: emailRegex,
                                    control: emailController,
                                    required: true,
                                    error: "Entrez un adresse email",
                                    icon: const Icon(Icons.mail),
                                  onTap: (){},
                                  validator: (value) {

                                },),

                                InputFieldPassword(
                                  label: 'Mot de passe',
                                  controller: passwordController,
                                  onTap: (){} ,
                                  focusNode: focusNode1,
                                  message: messages['Mot de passe'],
                                  toggleVisibility:
                                      () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  }, obscureText: obscurePassword,
                                  validator: (value ) {

                                      if (value == null || value.isEmpty) {
                                        return 'Le mot de passe est requis';
                                      }
                                      RegExp motDePasseRegExp = RegExp(
                                        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$',
                                      );
                                      if (!motDePasseRegExp.hasMatch(value)) {
                                        return 'Le mot de passe doit contenir au moins 8 caractères, une majuscule, un chiffre et un caractère spécial';
                                      }
                                      return null;
                                    }),

                                InputFieldPassword(
                                  label: 'Confirmer Mot de passe',
                                  controller: confirmPasswordController,
                                  onTap: (){} ,
                                  focusNode: focusNode2,
                                  message: messages['Confirmer Password'],
                                  toggleVisibility: () {
                                    setState(() {
                                      obscureConfirmPassword = !obscureConfirmPassword;
                                    });
                                  }, obscureText: obscureConfirmPassword,
                                  validator: (value) {
                                    if (value != passwordController.text) {
                                      return 'Les mots de passe ne correspondent pas';
                                    }
                                    return null;
                                },
                                ),

                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Button(text: 'Inscription', onTap: actionFunction),
                                    if(isLoading )
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                  ],
                                )
                              ],
                            )
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Avez-vous déjà un compte ?",
                                style: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    color: Colors.white),),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login',arguments: const Offset(1, 0));
                                  },
                                  child: const Text("Se connecter",
                                    style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
