import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/ui/TabViewWidget.dart';
import 'package:news/ui/aboutus.dart';
import 'package:news/ui/drawer/drawer6.dart';
import 'package:news/ui/home.dart';
import 'package:news/ui/search.dart';
import 'package:news/ui/video.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({Key key, this.initialIndex}) : super(key: key);
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void onChangePageIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      Home(initialIndex: widget.initialIndex),
      Video(),
      Search(),
      AboutUs(),
    ];

    List<Widget> _category = [
      TabViewWidget(index: 1),
      TabViewWidget(index: 2),
      TabViewWidget(index: 13),
      TabViewWidget(index: 3),
      TabViewWidget(index: 4)
    ];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsApp.blue,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: ImageIcon(AssetImage("assets/images/menu.png"), size: 28),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: false,
          title: Container(
//              height: 25,
//              width: 25,
              margin: EdgeInsets.only(right: 5),
              child: Image.asset(
                "assets/images/pnlogoheader.png",
//                fit: BoxFit.fill,
              )),
          actions: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
//                    height: 25,
//                    width: 25,
//                    decoration: BoxDecoration(
//                      image: new DecorationImage(
//                        image: new AssetImage("assets/images/call.png"),
////                        fit: BoxFit.fill,
//                      ),
//                    ),
                    child: Image.asset("assets/images/support.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "ទំនាក់ទំនងផ្សព្វផ្សាយ",
                            style: TextStyle(
                                color: ColorsApp.white,
                                fontSize: 10,
                                fontFamily: 'khmer'),
                          ),
                        ),
                        Text(
                          "010 481 481 / 012 816 262",
                          style: TextStyle(
                              color: ColorsApp.white,
                              fontSize: 10,
                              fontFamily: 'medium'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
      drawer: MyDrawer(
        onChangePageIndex: onChangePageIndex,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onChangePageIndex,
      backgroundColor: ColorsApp.blue,
      selectedItemColor: ColorsApp.white,
      unselectedItemColor: ColorsApp.greay,
      //showUnselectedLabels: false,
      //showSelectedLabels: false,

      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).appBarTheme.color,
          icon: ImageIcon(
            AssetImage("assets/images/shelter.png"),
            size: 34,
          ), //new Icon(CupertinoIcons.home),
          title: Text(
            "ទំព័រដើម",
            style: TextStyle(fontSize: 10, fontFamily: 'khmerosbattambang'),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/play-button.png"),
            size: 34,
          ),
          title: Text(
            "វីដេអូ",
            style: TextStyle(fontSize: 10, fontFamily: 'khmerosbattambang'),
          ),
        ),
        /*BottomNavigationBarItem(
          icon: const Icon(IconData(0xf3e5,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          title: Text('Deals',
          ),
        ),*/
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/magnifying-glass (3).png"),
            size: 34,
          ),
          title: Text(
            "ស្វែងរក",
            style: TextStyle(fontSize: 10, fontFamily: 'khmerosbattambang'),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/images/Group 177.png"),
            size: 34,
          ),
          title: Text(
            "អំពីយើង",
            style: TextStyle(fontSize: 10, fontFamily: 'khmerosbattambang'),
          ),
        ),
      ],
    );
  }
}
