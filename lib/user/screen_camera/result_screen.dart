import 'dart:io';

import 'package:ewera/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenResult extends StatefulWidget {
  const ScreenResult({super.key,required this.image});
  final File image;

  @override
  State<ScreenResult> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ScreenResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withAlpha(130),
                      BlendMode.darken),
                  image: FileImage(widget.image),
                  fit: BoxFit.cover),
      
            ),
          )
        ],
      ),
    );
  }
}
