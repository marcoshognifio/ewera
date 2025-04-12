import 'dart:io';

import 'package:ewera/components/button.dart';
import 'package:ewera/user/screen_camera/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/data_class.dart';

class ScreenCamera extends StatefulWidget {
  const ScreenCamera({super.key});

  @override
  State<ScreenCamera> createState() => _ScreenCameraState();
}

class _ScreenCameraState extends State<ScreenCamera> {

  XFile? image;

  final ImagePicker _picker = ImagePicker();

  // Fonction pour sélectionner une image depuis la galerie
  Future<void> _pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        validImage();
      }
  }

  // Fonction pour prendre une photo avec l'appareil photo
  Future<void> _takePhoto() async {
    image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        validImage();
      }
  }

  validImage(){
    Navigator.of(context).push(
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:(context, animation, secondAnimation)=> ScreenResult(image: File(image!.path)),
            transitionsBuilder: (context, animation, secondAnimation,child) {
              var begin=const Offset(1.0, 0.0);
              var end=const Offset(0.0, 0.0);
              var tween=Tween(begin: begin,end:end);
              return  SlideTransition(position: animation.drive((tween)),child: child);
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Navigator(

          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (context){
                  return Center(
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(text: 'Scanner Plante', onTap: _takePhoto),
                          Padding(
                            padding: const EdgeInsets.only(top:15),
                            child: SizedBox(
                              width: screenWidth*0.8,
                              height: screenHeight*0.06,
                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, //Color(0xff2f52f6),
                                  padding:const  EdgeInsets.only(top: 10, bottom: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: colorApp, width: 2),
                                  ),
                                ),
                                onPressed: _pickImage,
                                child: Text('Choisir Plante',style: TextStyle(
                                    fontFamily: 'Roboto-Regular',
                                    color: colorApp,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: 3,
                                    letterSpacing: 1)
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  ) ;
                }
            );
          }
      ),
    );
  }
}
