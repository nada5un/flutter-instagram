import "package:flutter/material.dart";

//다른파일에서 못씀
var _var1;

var theme = ThemeData(
    //버튼 스타일 지정 방법
    // textButtonTheme: TextButtonThemeData(
    //     style: TextButton.styleFrom(
    //         backgroundColor: Colors.grey,
    //         textStyle: TextStyle(color: Colors.black)
    //     )
    // ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
    ),
    //아이콘 스타일 통일
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black,fontSize: 25),
        actionsIconTheme: IconThemeData(color: Colors.black)
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color:Colors.red),
        bodyText2: TextStyle(color: Colors.black)
    )
);