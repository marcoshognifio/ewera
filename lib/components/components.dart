import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_plante/components/data_class.dart';

//ignore: must_be_immutable
class EntryField extends StatefulWidget {
  EntryField({super.key,required this.text,required this.type,required this.express,
              required this.control,required this.required,required this.error,required this.icon});
  String  text, type;
  RegExp express;
  TextEditingController control;
  bool required;
  String error;
  Icon icon;

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 35,right: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:  10.0),
            child: Text(widget.text,style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.white
            ),),
          ),
          Container(
            decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius:  BorderRadius.circular(5),
            ),
            child: TextFormField(
                  readOnly:  widget.type == 'date'? true:false,
                  showCursor: widget.type == 'date'? false:true,
                  style: TextStyle(
                    color: colorApp,
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                  onTap: widget.type != 'date'? (){}:
                      ()async{
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    widget.control.text = "${pickedDate?.day}-${pickedDate?.month}-${pickedDate?.year}";
                  },
                  controller: widget.control,
                  obscureText: widget.type == 'password',
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.all(0),
                      icon: Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: widget.icon,
                      ),
                      iconColor: colorApp,
                      hoverColor: Colors.white,
                      labelText: widget.text,
                      labelStyle: TextStyle(
                        color: colorApp,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none
                          )
                      )
                  ),
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
}

class EntrySearch extends StatefulWidget {
  EntrySearch({super.key,required this.text});
  String text;

  @override
  State<EntrySearch> createState() => _EntrySearchState();
}

class _EntrySearchState extends State<EntrySearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(
                  2.0,
                  2.0,
                ), //Offset
                blurRadius: 3.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Color(0xff363636),
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
              )
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(0),
            iconColor: colorApp,
            hoverColor: Colors.white,
            labelText: widget.text,
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: null,
            ),
            labelStyle: TextStyle(
                color: colorApp,
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none
                )
            )
        ),
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
              style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
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


