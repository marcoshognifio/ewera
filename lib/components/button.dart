import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ButtonWelcome extends StatelessWidget {
  ButtonWelcome({super.key, required this.text, required this.onTap});
   final String text;
   final VoidCallback onTap;

  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      wordSpacing: 3,
      letterSpacing: 1);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, //Color(0xff2f52f6),
            padding:const  EdgeInsets.only(top: 15, bottom: 15),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(color: Colors.white)
            ),
          ),
          onPressed: onTap,
          child: Text(text,style: textStyle),
        ),
    );
  }
}

class Button extends StatelessWidget {
  Button({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  TextStyle textStyle=const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      wordSpacing: 3,
      letterSpacing: 1);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:  15.0,left: 50,right: 50),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF236718), //Color(0xff2f52f6),
                  padding:const  EdgeInsets.only(top: 20, bottom: 20),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: onTap,
                child: Text(text,style: textStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


