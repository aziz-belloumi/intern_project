import 'package:convergeimmob/constants/app_background.dart';
import 'package:flutter/material.dart';

class StartCreationProperty extends StatelessWidget {
  const StartCreationProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          children: [
            Image.asset("assets/images/home.png"),
          ],
        ),
      ),
    );
  }
}
