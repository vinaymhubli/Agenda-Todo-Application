import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/views/home.dart';
class SplashScren extends StatefulWidget {
  SplashScren({Key? key}) : super(key: key);

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>TodoHome()));
    });
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/splash_screen.json')
          ],
        ),
      ),
    );
  }
}