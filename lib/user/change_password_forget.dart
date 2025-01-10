import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class ChangePasswordForget extends StatefulWidget {
  const ChangePasswordForget({super.key});

  @override
  State<ChangePasswordForget> createState() => _ChangePasswordForgetState();
}

class _ChangePasswordForgetState extends State<ChangePasswordForget> {

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  String error ="";
  RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{4,}$");


  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'newPassword': passwordController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/forgot-password/reset-password/change-password");
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
        await Navigator.pushNamed(context, '/login',arguments: const Offset(1, 0));
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


                              Button(text: 'Valider', onTap: ()async {
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
