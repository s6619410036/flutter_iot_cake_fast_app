import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/views/cake_shop_list_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CakeShopListUi()),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_welcome.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                "สายด่วนกินเค้ก",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 68, 66, 69),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "CAKE CALL FAST",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 146, 140, 149),
                ),
              ),
              SizedBox(height: 10),
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 124, 119, 123),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
