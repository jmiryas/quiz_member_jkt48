import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loadingTime = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        loadingTime = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Quiz Member JKT48",
      home: loadingTime ? const SplashScreen() : const HomeScreen(),
    );
  }
}
