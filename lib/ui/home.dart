import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:dio/dio.dart';
import 'package:news/constant/data.dart';
import 'package:news/constant/endpoint.dart';
import 'package:news/ui/SingleVideo.dart';
import 'package:news/ui/TabViewWidget.dart';
import 'package:news/ui/WebView.dart';

class Home extends StatefulWidget {
  final int initialIndex;
  const Home({Key key, this.initialIndex}) : super(key: key);
  @override
  homeState createState() => homeState();
}

class homeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  int index;
  @override
  void initState() {
    super.initState();
    setState(() {
      index = widget.initialIndex;
    });
//    print(widget.initialIndex);
    _controller =
        new TabController(length: 5, vsync: this, initialIndex: index ?? 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: 5,
//          initialIndex: index ?? 0,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: ColorsApp.blue),
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
                    controller: _controller,
                    indicatorColor: Colors.red,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Container(
                        width: 80,
                        child: Text(
                          "ព័ត៌មានជាតិ",
                          style: TextStyle(fontSize: 11, fontFamily: 'khmer'),
                        ),
                      ),
                      Container(
                          width: 100,
                          child: Text("ព័ត៌មានអន្តរជាតិ",
                              style: TextStyle(
                                  fontSize: 11, fontFamily: 'khmer'))),
                      Container(
                          width: 80,
                          child: Text("ព័ត៌មានកីឡា",
                              style: TextStyle(
                                  fontSize: 11, fontFamily: 'khmer'))),
                      Container(
                          width: 100,
                          child: Text("សិល្បះនិងវប្បធម៏",
                              style: TextStyle(
                                  fontSize: 11, fontFamily: 'khmer'))),
                      Container(
                          width: 80,
                          child: Text("នយោបាយ",
                              style:
                                  TextStyle(fontSize: 11, fontFamily: 'khmer')))
                    ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(controller: _controller, children: [
                    TabViewWidget(index: 1),
                    TabViewWidget(index: 2),
                    TabViewWidget(index: 3),
                    TabViewWidget(index: 4),
                    TabViewWidget(index: 13),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
