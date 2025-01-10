import 'package:ewera/components/data_class.dart';
import 'package:flutter/material.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text('Français'),
              leading: Radio<String>(
                value: 'fr',
                groupValue: languageIndex,
                onChanged: (value) {
                  setState(() {
                    languageIndex = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Anglais'),
              leading: Radio<String>(
                value: 'en',
                groupValue: languageIndex,
                onChanged: (value) {
                  setState(() {
                    languageIndex = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
