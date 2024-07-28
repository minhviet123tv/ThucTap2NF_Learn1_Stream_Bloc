import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//I. Run App
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: HomePage(),
      ),
      routes: {

      },
    );
  }
}

//II. Home Page
class HomePage extends StatelessWidget{

  static const String routeName = "";
  var textStyle1 = const TextStyle(fontSize: 20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: 
            ElevatedButton(
              onPressed: () {

              },
              child: Text("Button", style: textStyle1,),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.lightGreen,
    );
  }
}
