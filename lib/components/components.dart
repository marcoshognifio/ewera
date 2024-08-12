import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.only(top: 15,left: 50,right: 50),
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
                  style: const TextStyle(
                    color: Color(0xFF236718),
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
                      iconColor: const Color(0xFF236718),
                      hoverColor: Colors.white,
                      labelText: widget.text,
                      labelStyle: const TextStyle(
                        color: Color(0xFF236718),
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


