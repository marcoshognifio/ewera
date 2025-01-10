import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
  final confirmPasswordController = TextEditingController();
  RegExp passwordRegex = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{4,}$");


  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    passwordNewController.dispose();
    passwordConfirmController.dispose();
  }

  actionFunction() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> request = {
        'password': passwordController.text,
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
            "Authorization": "Bearer $token"
          }
      );

      print('object${response.body}');
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
      body: Container(
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
