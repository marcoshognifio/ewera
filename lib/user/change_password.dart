import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordNewController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool isLoading = false;
  String error = "";
  String? errorMessage;
  String? passwordError;
  final confirmPasswordController = TextEditingController();
  RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{4,}$");

  @override
  void initState() {

    super.initState();
    confirmPasswordController.addListener(_validatePasswords);
    passwordController.addListener(_validatePasswordFormat);
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    passwordNewController.dispose();
    passwordConfirmController.dispose();
  }

  void _validatePasswordFormat() {
    setState(() {
      final password = passwordController.text;
      final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$'); // Exemple : au moins 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre

      if (!regex.hasMatch(password)) {
        passwordError = "Le mot de passe doit contenir au moins 8 caractères, 1 majuscule, 1 minuscule et 1 chiffre.";
      } else {
        passwordError = null; // Pas d'erreur si le mot de passe est valide
      }
    });
  }

  void _validatePasswords() {
    setState(() {
      if (confirmPasswordController.text != passwordController.text) {
        errorMessage = "Les mots de passe ne correspondent pas.";
      } else {
        errorMessage = null; // Pas d'erreur
      }
    });
  }
  actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'currentPassword': passwordController.text,
        'newPassword': passwordNewController.text
      };

      setState(() {
        isLoading = true;
      });
      final uri = Uri.parse("$url/auth/change-password");
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
          SnackBar(content: Text('Mot de passe modifié avec succès !')),
        );
        Navigator.pop(context);
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Changer Mot de Passe',context),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              EntryFieldEdit(
                text: "MOT DE PASSE",
                type: "password",
                express: RegExp(r''),
                control: passwordController,
                required: false,
                error: "",
              ),

              EntryFieldEdit(
                text: "NOUVEAU",
                type: "password",
                express: RegExp(r''),
                control: passwordNewController,
                required: true,
                error: "",
              ),

              EntryFieldEdit(
                text: "CONFIRMATION",
                type: "password",
                express: RegExp(r''),
                control: passwordConfirmController,
                required: false,
                error: "",
              ),

              SizedBox(height: 16),
              if (errorMessage == null && confirmPasswordController.text.isNotEmpty)
                Text(
                  "Les mots de passe correspondent ! 🎉",
                  style: TextStyle(color: Colors.green),
                ),

              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Button(text: 'MODIFIER', onTap: actionFunction),
              )
            ],
          ),
        ),
      ),
    );
  }
}
