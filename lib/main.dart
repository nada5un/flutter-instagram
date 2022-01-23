import 'package:flutter/material.dart';
import "./style.dart" as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];

  getData() async{
    var request = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    setState(() {
      data = jsonDecode(request.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      body: [
        Home(
          data:data
        ),Text("샵페이지")][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,   // <-- HERE
        showUnselectedLabels: false, // <-- AND HERE
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(label:"홈",icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label: "샵",icon: Icon(Icons.shopping_bag_outlined))
        ],
      ),
    );
  }
}

//홈화면
class Home extends StatelessWidget {
  Home({
    Key? key,
    this.data
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    print(data);
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (c,i){
          return Column(
              children: [
                Image.network(data[i]["image"]),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("좋아요 ${data[i]["likes"]}",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(data[i]["user"]),
                      Text(data[i]["content"])
                    ],
                  ),
                )
              ]
          );
        }
    );
  }
}
