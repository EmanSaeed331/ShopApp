import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Column(
          children: [
            Text('Login Screen',
            style: TextStyle(
              fontSize: 20,

            ),
            ),
          ],

      ),
    );
  }
}
