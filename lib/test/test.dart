import 'package:flutter/material.dart';




class CustomTextField extends StatefulWidget {
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:100.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (_isTextEmpty)
              Text(
                "Saisissez ici",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            TextField(
              controller: _controller,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
