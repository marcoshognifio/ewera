import 'package:flutter/material.dart';
import 'package:projet_plante/components/components.dart';
import 'package:projet_plante/components/data_class.dart';

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
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            image:DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5),
                  BlendMode.darken),
                image: const AssetImage('assets/images/image2.png'),
                fit: BoxFit.fill),
            
        ),
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 50,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_forward_ios,color:colorApp),
                    onPressed: () { Navigator.pushNamed(context, '/inscription'); },
                  ),
                ),
            ),
            Center( child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content(),
              ],
            )),
          ],
        )
      ),
    );

  }

  Widget content(){

    return Container(
      child: Column(
        children: [
           Text("Welcome Back!",
            style: textLogin,
          ),
          Text("Welcome back we missed you",
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w700
            ),
          ),
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
                      icon: const Icon(Icons.mail)),

                  EntryField(
                      text: "Password",
                      type: "password",
                      express: RegExp(r''),
                      control: passwordController,
                      required: true,
                      error: "",
                      icon: const Icon(Icons.vpn_key_outlined)),

                  Padding(
                    padding: const EdgeInsets.only(top:  15.0,right: 50),
                    child: Row(
                        children: [
                          Expanded(
                            child: Text('Forgot Password ?',style: TextStyle(
                              color: Colors.white.withOpacity(0.7),),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                  ),

                  Button(text: 'Connexion', onTap: () { Navigator.pushNamed(context, '/welcomeUser'); },)
                ],
              )
          )
        ],
      ),
    );
  }
}
