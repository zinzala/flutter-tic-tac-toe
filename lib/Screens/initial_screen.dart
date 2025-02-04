import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Screens/home_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenOrientation = MediaQuery
        .of(context)
        .orientation;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'tic tac toe',
              style: TextStyle(fontFamily: 'GameFont',
                  color: Colors.white,
                  fontSize: screenWidth * 0.07),
            ),
            SizedBox(
              height: screenWidth * 0.10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage(),),);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                height: screenWidth * 0.15,
                width: screenWidth * 0.50,
                child: Center(
                  child: Text(
                    'Play Game',
                    style: TextStyle(
                        fontFamily: 'GameFont', fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
