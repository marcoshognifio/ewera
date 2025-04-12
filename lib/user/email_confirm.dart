import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/background-image.dart';
import '../components/button.dart';
import '../components/data_class.dart';

class EmailConfirmationPage extends StatefulWidget {
  const EmailConfirmationPage({super.key, required this.data});
  final Map<String,dynamic> data;

  @override
  EmailConfirmationPageState createState() => EmailConfirmationPageState();
}

class EmailConfirmationPageState extends State<EmailConfirmationPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  String _code = "";
  bool isLoading = false;
  String error = "";

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
    super.initState();
  }

  void _onTextChanged(int index, String value) {
    // Mettre à jour _code à chaque changement
    setState(() {
      _code = _controllers.map((controller) => controller.text).join();
    });

    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  actionFunction() async {

    setState(() {
      isLoading = true;
    });

    if (_code.length == 6){
      Map<String, dynamic> request;
      String urlHelp = '';

      if (widget.data['type'] == 'create') {
        request = {
          'token': token,
          'code': _code,
        };
        urlHelp = '$url/auth/confirm-email';
      } else {
        request = {
          'token': token,
          'resetCode': _code,
        };
        urlHelp = '$url/auth/forgot-password/reset-password';
      }

      final uri = Uri.parse(urlHelp);
      final response = await http.post(
        uri,
        body: jsonEncode(request),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });


      if (data['message'] == 'succes') {
        token = data['token'];
        if (widget.data['type'] == 'create') {
          await Navigator.pushNamed(context, '/login');
        } else {
          await Navigator.pushNamed(context, '/changeForgetPassword');
        }
      } else {
        setState(() {
          error = data['message'];
        });
      }
    }
    else {
      setState(() {
        error = "Veuillez remplir tous les champs.";
      });
    }
  }

  reviewCode() async {

    setState(() {
      isLoading = true;
    });

    String urlHelp = '';
    if (widget.data['type'] == 'create') {
      await Navigator.pushNamed(context, '/confirmEmail',arguments: {'email':widget.data["email"],'type':'create' });
    }else {
      urlHelp = "$url/auth/forgot-password";
    }
      final uri = Uri.parse("$url/auth/forgot-password");
      final response = await http.post(uri,
          body:jsonEncode({'email':widget.data['email']}),
          headers: {"Content-Type": "application/json","Authorization":"Bearer $token"}
      );
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        isLoading = false;
      });

        token = data['token'];
        await Navigator.pushNamed(context, '/confirmEmail',arguments:widget.data);
    }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.08),
                Text(
                  "Vérification de l'Email",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Entrez le code qui vous a été envoyé sur votre email :",
                  style: TextStyle(fontSize: screenWidth*0.045, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                if (error.isNotEmpty)
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _focusNodes[index].hasFocus
                              ? Colors.white
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                        showCursor: false,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        onChanged: (value) async {
                          _onTextChanged(index, value);
                          // Si tous les champs sont remplis, appeler la fonction d'action
                          if (_code.length == 6) {
                            await actionFunction();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    // Supprime le padding
                    minimumSize: Size.zero,
                  ),
                  onPressed: reviewCode,
                  child: Text('Renvoyer le code ?',
                    style: TextStyle(
                    color: Colors.white.withAlpha(200),),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 30),
                Button(
                  text: 'Confirmer',
                  onTap: actionFunction
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
