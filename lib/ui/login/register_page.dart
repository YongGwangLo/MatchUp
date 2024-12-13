import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "회원가입",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      )),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              widthFactor: double.infinity,
              heightFactor: 2,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lightGray,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
