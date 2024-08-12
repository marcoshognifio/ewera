import 'package:flutter/material.dart';
import 'package:projet_plante/components/components.dart';

import '../components/button.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _LoginState();
}

class _LoginState extends State<InscriptionPage> {

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                    icon: const Icon(Icons.arrow_back_ios_rounded,color:Color(0xFF236718),),
                    onPressed: () { Navigator.pushNamed(context,'/login',arguments:const Offset(-1, 0));  },
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
          const Text("Get Started Free",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              wordSpacing: 5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Free Forever No Credit Card Needed",
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
                      text: "Username",
                      type: "text",
                      express: RegExp(r'^[a-zA-Z]+( )?[a-zA-Z]+$'),
                      control: usernameController,
                      required: true,
                      error: "",
                      icon: const Icon(Icons.account_circle_sharp)),

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

                  EntryField(
                      text: "Confirmer Password",
                      type: "password",
                      express: RegExp(r''),
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
                            color: Colors.white.withOpacity(0.7),),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Button(text: 'Inscription', onTap: () {  },)
                ],
              )
          )
        ],
      ),
    );
  }
}
