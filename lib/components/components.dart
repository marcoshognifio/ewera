import 'package:flutter/material.dart';
import 'package:ewera/components/data_class.dart';

//ignore: must_be_immutable

class EntryField extends StatelessWidget {
  EntryField({super.key,required this.text,required this.express,
    required this.control,required this.required,required this.error,
    required this.icon, this.onTap,required this.validator});
  String  text;
  VoidCallback? onTap;
  RegExp express;
  TextEditingController control;
  bool required;
  String? error;
  Icon icon;
  String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:  10.0),
            child: Text(text,style: const TextStyle(
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white
            ),),
          ),
          SizedBox(
            width: screenWidth*0.8,
            child: TextFormField(
              onTap: onTap,
              style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: colorApp,
                  fontWeight: FontWeight.w700,
                  fontSize: 16
              ),
              cursorColor: colorApp,
              controller: control,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 10),
                  child: icon,
                ),
                prefixIconColor: colorApp,
                hoverColor: Colors.white,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none
                ),
              ),
              validator: (value) {
                if(required == true )
                {
                  if(value!.isEmpty){
                    return 'Ce champ est obligatoire';
                  }
                  else{
                    if (!express.hasMatch(value))
                    {
                      return error;
                    }
                    return null;
                  }
                }
                else {
                  return null;
                }
              },

            ),
          ),
        ],
      ),
    ) ;
  }
}




class EntrySearch extends StatefulWidget {
  EntrySearch({super.key, required this.text,required this.formKey,required this.control,required this.onTap});
  final String text;
  final GlobalKey<FormState> formKey;
  TextEditingController control;
  final VoidCallback onTap;

  @override
  State<EntrySearch> createState() => _EntrySearchState();
}

class _EntrySearchState extends State<EntrySearch> {
  bool _isTextEmpty = true;

  @override
  void initState() {
    widget.control.addListener(() {
      setState(() {
        _isTextEmpty = widget.control.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(20),
            offset: const Offset(1.0, 1.0),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          ),
          const BoxShadow(
            color: Color(0xff363636),
            offset: Offset(0.0, 0.0),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
      alignment: Alignment.centerLeft,
        children: [
          Form(
            key : widget.formKey,
            child: TextField(
              controller: widget.control,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(left: 20),
                hoverColor: Colors.white,
                labelStyle: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: colorApp,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          if (_isTextEmpty)
          IgnorePointer(
            ignoring: true, // Empêche ce widget de capturer les clics.
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: IconButton(
              onPressed: widget.onTap,
              icon: const Icon(
                Icons.search,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



Widget emptyPage(String text,Widget addWidget){

  return Center(
    child: Container(
      width: 400,
      alignment: Alignment.center,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,textAlign: TextAlign.center,
              style:const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 15),),
            addWidget
          ],
        ),
      ),
    ),
  );
}



class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size = 25;
  final Gradient gradient = LinearGradient(
                              colors: listColor,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              );

  GradientIcon({super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(icon, size: size, color: Colors.white,),
    );
  }
}

class IsObscured {
  bool value;
  IsObscured(this.value);
}

//ignore: must_be_immutable
class EntryFieldEdit extends StatefulWidget {
  EntryFieldEdit({super.key,required this.text,required this.type,required this.express,
    required this.control,required this.required,required this.error});
  String  text, type;
  RegExp express;
  TextEditingController control;
  bool required;
  String error;

  IsObscured isObscured = IsObscured(true);

  @override
  State<EntryFieldEdit> createState() => _EntryFieldEditState();
}

class _EntryFieldEditState extends State<EntryFieldEdit> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 35,right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text,style:  TextStyle(
                fontFamily: 'Roboto-Regular',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.grey.shade500
            ),
          ),
          Container(
            child: TextFormField(
              style: const TextStyle(
                  fontFamily: 'Roboto-Regular',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16
              ),
              cursorColor: colorApp,
              enabled: widget.text == 'EMAIL' ? false : true,
              controller: widget.control,
              obscureText: widget.type == 'password' ? widget.isObscured.value : false ,
              decoration: widget.type == 'password' ? password(): textEntry(),
              validator: (value) {
                if(widget.required == true )
                {
                  if(value!.isEmpty){
                    return 'Ce champ est obligatoire';
                  }
                  if (!widget.express.hasMatch(value))
                  {
                    return widget.error;
                  }
                  return null;
                }
                else
                {
                  if (value!.isNotEmpty && !widget.express.hasMatch(value))
                  {
                    return widget.error;
                  }
                  else {
                    return null;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration textEntry(){
    return  InputDecoration(
        fillColor: Colors.white,
        hoverColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500.withOpacity(0.3),width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500.withOpacity(0.3),width: 2),
        ),
    );
  }

  InputDecoration password(){
    return InputDecoration(
        fillColor: Colors.white,
        hoverColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500.withOpacity(0.3),width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500.withOpacity(0.3),width: 2),
        ),
        suffixIcon: IconButton(
            padding: const EdgeInsetsDirectional.only(end: 12),
            onPressed:(){
              setState(() {
                widget.isObscured.value = widget.isObscured.value == true ? false:true;
              });
            }
            , icon: const Icon(Icons.visibility)
        )
    );
  }
}