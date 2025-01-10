import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  String error ="";

  actionFunction() async {
    if(formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'email': emailController.text,
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/forgot-password");
      final response = await http.post(uri,
          body:jsonEncode(request),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"}
      );
      final Map<String, dynamic> data = json.decode(response.body);

      print(data);
      setState(() {
        isLoading = false;
      });
      if (data['message'] == 'notExists') {
        setState(() {
          error = 'Votre identifiant est incorrect';
        });

      }
      else{
        token = data['token'];
        await Navigator.pushNamed(context, '/confirmEmail',arguments:'forget');
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
                SizedBox(height: 70,),
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
                                  express: RegExp(r'^[a-zA-Z0-9]+\@{1}[a-z]+\.{1}[a-z]+$'),
                                  control: emailController,
                                  required: true,
                                  error: "",
                                  icon: const Icon(Icons.mail)
                              ),


                              Button(text: 'Vaider', onTap: ()async {
                                await actionFunction();
                                //Navigator.pushNamed(context, '/welcomeUser');
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
