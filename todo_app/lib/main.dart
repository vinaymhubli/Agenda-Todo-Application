import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/onboard/views/onboard_home.dart';
import 'package:todo_app/views/splash_screen.dart';
int? initScreen;
Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
 SharedPreferences preferences= await SharedPreferences.getInstance();
 initScreen= (await preferences.getInt('initScreen'));
 await preferences.setInt('initScreen',1);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       
       initialRoute: initScreen==0|| initScreen==null? 'onboard':'home',
      routes: {
        'home':(context) => SplashScren(),
        'onboard':(context) => OnbordingHome()
      },  
    );
  }
}