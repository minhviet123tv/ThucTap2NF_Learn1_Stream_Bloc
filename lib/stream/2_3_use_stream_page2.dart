import 'package:flutter/material.dart';
import 'package:stream_bloc/stream/1_2_stream_controller.dart';

//II. Home Page
class HomePage2 extends StatefulWidget {
  static const String routeName = "";

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  MyStreamNumber myStreamNumber = MyStreamNumber();
  MyStreamString myStreamString = MyStreamString();
  var textStyle1 = const TextStyle(fontSize: 20, color: Colors.black);

  @override
  void dispose() {
    super.dispose();
    myStreamNumber.controller.close();
    myStreamString.controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stream controller Page2"),
          backgroundColor: Colors.blue,
        ),
        body: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  //I. Add number
                  StreamBuilder(
                    stream: myStreamNumber.stream,
                    builder: (context, snapshot) => snapshot.hasData ? Text(snapshot.data.toString(), style: textStyle1,) : const Text("Dữ liệu hiện tại của MyStreamNumber"),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        myStreamNumber.increase();
                      },
                      child: Text(
                        "Button",
                        style: textStyle1,
                      ),
                    ),
                  ),

                  //II. Add string và thể hiện tính danh sách
                  TextField(
                    onChanged: (data) {
                      myStreamString.addData(data);
                    },
                  ),
                  StreamBuilder(
                    stream: myStreamString.stream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Text('Current data: ${snapshot.data.toString()}', style: textStyle1,);
                      } else {
                        return const Text("Dữ liệu hiện tại của MyStreamString");
                      }
                    },),
                  StreamBuilder(
                    stream: myStreamString.stream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.data[0].toString().isNotEmpty){
                        return Text('First data: ${snapshot.data[0].toString()}', style: textStyle1,);
                      } else {
                        return const Text("Dữ liệu 0 của MyStreamString");
                      }
                    },),
                  StreamBuilder(
                    stream: myStreamString.stream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData && snapshot.data[1].toString().isNotEmpty){
                        return Text('Second data: ${snapshot.data[1].toString()}', style: textStyle1,);
                      } else {
                        return const Text("Dữ liệu 1 của MyStreamString");
                      }
                    },),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: textStyle1,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
