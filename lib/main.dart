import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Directionality(
      textDirection: TextDirection.rtl,
          child: MaterialApp(
        
        title: "لیست محصولات",
        
        home: HomePage(),
      ),
    );
  }

}