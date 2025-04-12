import 'package:flutter/material.dart';
import 'data_class.dart';

class InputFieldPassword extends StatefulWidget {
  final String label;
  final Function onTap;
  final FocusNode focusNode;
  final String? message;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback toggleVisibility;
  final bool obscureText;
  String? Function(String?) validator;

  InputFieldPassword({
    required this.label,
    required this.onTap,
    required this.focusNode,
    this.message,
    required this.obscureText,
    required this.controller,
    this.onChanged, required this.toggleVisibility,
    required this.validator
  });

  @override
  State<InputFieldPassword> createState() => _InputFieldPasswordState();
}

class _InputFieldPasswordState extends State<InputFieldPassword> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:  10.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.8,
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              focusNode: widget.focusNode,
              onTap: () => widget.onTap(),
              style: TextStyle(
              fontFamily: 'Roboto-Regular',
              color: colorApp,
              fontWeight: FontWeight.w700,
              fontSize: 16
              ),
              onChanged: (value) {
                // Efface le message d'erreur lorsque l'utilisateur commence à taper
                if (widget.onChanged != null) widget.onChanged!(value);

                // Si vous avez une logique de validation, vous pouvez également mettre à jour ici
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 10),
                  child: const Icon(Icons.vpn_key_outlined),
                ),
                prefixIconColor: colorApp,
                hoverColor: Colors.white,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: widget.toggleVisibility,
                ),
              ),
              validator: widget.validator,
            ),
          ),
          if (widget.message != null && widget.message!.isNotEmpty)
            SizedBox(
              width: screenWidth * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.message!,
                  style: TextStyle(
                      color: widget.message!.contains("valide") || widget.message!.contains("correspondant")
                          ? Colors.green
                          : Colors.red
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
