import 'package:flutter/material.dart';
import "./style.dart" as style;

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Instagram"),
        actions: [
          IconButton(
              icon:Icon(Icons.add_box_outlined),
              onPressed: (){},
              iconSize: 30,
          )
        ]
      ),
      // body: Theme(
      //     data: ThemeData(
      //       textTheme: TextTheme()
      //     ),
      //     child: Container()
      // ),
      body: Text("안녕",style: Theme.of(context).textTheme.bodyText2),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,   // <-- HERE
        showUnselectedLabels: false, // <-- AND HERE
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(title:Text(""),icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(title:Text(""),icon: Icon(Icons.shopping_bag_outlined))
        ],

      ),
    );
  }
}
