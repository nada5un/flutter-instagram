import 'package:flutter/material.dart';
import "./style.dart" as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:flutter/rendering.dart";

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
  //0:false , 1:true
  int isScrollDown = 0;

  getData() async{
    var request = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (request.statusCode == 200){
      setState(() {
        data = jsonDecode(request.body);
      });
    }else{

    }
  }

  appendPost(Map value)=>setState((){
    print(value);
    data.add(value);
  });

  changeTab(int value)=>setState((){
    tab = value;
  });

  changeBottomState(int value)=>setState((){
    isScrollDown = value;
  });

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
          data:data,
          appendPost:appendPost,
          changeBottomState:changeBottomState
        ),Text("샵페이지")
      ][tab],

      bottomNavigationBar: Offstage(
        offstage: isScrollDown==1,
        child: Bottom(
            tab:tab,
            changeTab:changeTab
        ),
      )
    );
  }
}

//홈화면
class Home extends StatefulWidget {
  Home({
    Key? key,
    this.data,
    required this.appendPost,
    required this.changeBottomState
  }) : super(key: key);

  final data;
  final Function(Map value) appendPost;
  final Function(int value) changeBottomState;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scroll = ScrollController();

  getScroll() async{
    var request = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    print(request.body);
    widget.appendPost(jsonDecode(request.body));
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      //최대 스크롤 했을 경우
      if (scroll.position.pixels == scroll.position.maxScrollExtent){
        getScroll();
      }
      //아래로 스크롤
      if(scroll.position.userScrollDirection == ScrollDirection.reverse){
        widget.changeBottomState(1);
      }else{
        widget.changeBottomState(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty){
      return ListView.builder(
          itemCount: widget.data.length,
          controller: scroll,
          itemBuilder: (c,i){
            return Column(
                children: [
                  Image.network(widget.data[i]["image"]),
                  Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("좋아요 ${widget.data[i]["likes"]}",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(widget.data[i]["user"]),
                        Text(widget.data[i]["content"])
                      ],
                    ),
                  )
                ]
            );
          }
      );
    }else{
      return CircularProgressIndicator();
    }
  }
}

//하단 바
class Bottom extends StatefulWidget {
  Bottom({
    Key? key,
    this.tab,
    required this.changeTab,
  }) : super(key: key);

  final tab;
  final Function(int value) changeTab;

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,   // <-- HERE
      showUnselectedLabels: false, // <-- AND HERE
      onTap: (i){
        widget.changeTab(i);
      },
      items: [
        BottomNavigationBarItem(label:"홈",icon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(label: "샵",icon: Icon(Icons.shopping_bag_outlined))
      ],
    );
  }
}
