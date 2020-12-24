import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> items = [];

  void getData() async {
    http.Response response =
        await http.get('https://baconipsum.com/api/?type=meat-and-filler');
    List length = jsonDecode(response.body);
    for (int i = 0; i < length.length; i++) {
      setState(() {
        items.add(GestureDetector(
          onTap: () {
            print("link trigger here");
          },
          child: Container(
            padding: EdgeInsets.all(18.0),
            height: 450,
            color: Colors.deepOrange,
            child: Center(
                child: Text(
              jsonDecode(response.body).toString().substring(0, 350),
              style: TextStyle(backgroundColor: Colors.indigo, fontSize: 18),
            )),
          ),
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Full Screen Scroller"),
        ),
        body: CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false,
              aspectRatio: 1.5,
              enlargeCenterPage: true,
              height: 600,
              scrollDirection: Axis.vertical),
          items: items,
        ),
      ),
    );
  }
}
