import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news/constant/colors.dart';
import 'package:news/mainscreen.dart';
import 'package:news/ui/TabViewWidget.dart';
import 'package:news/ui/home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class MyDrawer extends StatefulWidget {
  final ValueChanged<int> onChangePageIndex;
  MyDrawer({Key key, this.onChangePageIndex}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  final TextStyle _biggerFont =
      const TextStyle(fontSize: 24, color: Colors.white);

  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  Future initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
    //getActiveAccount();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryIconThemeColor =
        Theme.of(context).iconTheme.color.withOpacity(0.4);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: ColorsApp.blue),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsApp.blue,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
//                        height: 25,
//                        width: 25,
                        margin: EdgeInsets.only(left: 15),
                        child: Image.asset(
                          "assets/images/pnlogoheader.png",
//                          fit: BoxFit.fill,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 25,
                          width: 25,
                          margin: EdgeInsets.only(right: 15),
                          child: Image.asset(
                            "assets/images/close.png",
                            fit: BoxFit.fill,
                            color: ColorsApp.white.withOpacity(0.2),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Divider(
                  color: ColorsApp.greay,
                  height: 20,
                )),
            Expanded(
              child: ListView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: Column(
//                          mainAxisSize: MainAxisSize.max,
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
//                                widget.onChangePageIndex(0);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(
                                          initialIndex: 0,
                                        )));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Image.asset(
                                        "assets/images/cambodia.png",
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ពត័មានជាតិ",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
//                                widget.onChangePageIndex(1);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(initialIndex: 1)));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Image.asset(
                                        "assets/images/world.png",
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ពត័មានអន្តរជាតិ",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
//                                widget.onChangePageIndex(2);
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(initialIndex: 2)));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Image.asset(
                                        "assets/images/politics.png",
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "នយោបាយ",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
//                                widget.onChangePageIndex(3);
                                Navigator.pop(context);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(
                                          initialIndex: 3,
                                        )));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Image.asset(
                                        "assets/images/exercise.png",
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "ពត័មានកីឡា",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
//                                widget.onChangePageIndex(4);
                                Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(initialIndex: 4)));
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "assets/images/drawing.png",
//                                        height: 20.0,
//                                        width: 20.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "សិល្បះនិងវប្បធម៏",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
//                            ListTile(
//                              title: Text("ពត័មានជាតិ",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'khmerosbattambang')),
//                              leading: ImageIcon(
//                                AssetImage("assets/images/drawer_2.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              onTap: () {
//                                widget.onChangePageIndex(0);
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                            /* ScopedModelDescendant<AppStateModel>(builder: (context, child, model) {
//                                  return model.loggedIn ? ListTile(
//                                    title:  Text(widget.appStateModel.blocks.localeText.account),
//                                    leading: Icon(FlutterIcons.user_fea),
//                                    trailing: Icon(CupertinoIcons.right_chevron,color: primaryIconThemeColor,),
//                                    onTap: () {
//                                      widget.onChangePageIndex(3);
//                                      Navigator.of(context).pop();
//                                    },
//                                  ) : Container();
//                                }
//                              ),*/
//                            ListTile(
//                              title: Text(
//                                "ពត័មានអន្តរជាតិ",
//                                style: TextStyle(
//                                    color: ColorsApp.white,
//                                    fontSize: 12,
//                                    fontFamily: 'khmerosbattambang'),
//                              ),
//                              leading: ImageIcon(
//                                AssetImage(
//                                  "assets/images/drawer_2.png",
//                                ),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              onTap: () {
//                                widget.onChangePageIndex(1);
//                                Navigator.of(context).pop();
//                              },
//                            ),
//                            ListTile(
//                              leading: ImageIcon(
//                                AssetImage("assets/images/drawer_3.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              title: Text("នយោបាយ",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'khmerosbattambang')),
//                              onTap: () {
//                                var filter = new Map<String, dynamic>();
//                                filter['featured'] = '1';
//                                /*Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => ProductsWidget(
//                                              filter: filter,
//                                              name: widget.appStateModel.blocks.localeText.featured)));*/
//                              },
//                            ),
//                            ListTile(
//                              leading: ImageIcon(
//                                AssetImage("assets/images/drawer_5.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              title: Text("ពត័មានកីឡា",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'khmerosbattambang')),
//                              onTap: () {
//                                var filter = new Map<String, dynamic>();
//                                filter['on_sale'] = '1';
//                                /*Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => ProductsWidget(
//                                              filter: filter,
//                                              name: widget.appStateModel.blocks.localeText.sales)));*/
//                              },
//                            ),
//                            ListTile(
//                              leading: ImageIcon(
//                                AssetImage("assets/images/drawer_4.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              title: Text("សិល្បះនិងវប្បធម៏",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'khmerosbattambang')),
//                              onTap: () {
//                                var filter = new Map<String, dynamic>();
//                                filter['on_sale'] = '1';
//                                /*Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => ProductsWidget(
//                                              filter: filter,
//                                              name: widget.appStateModel.blocks.localeText.sales)));*/
//                              },
//                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15.0),
                                child: Divider(
                                  color: ColorsApp.greay,
                                  height: 20,
                                )),
                            InkWell(
                              onTap: () {
//                                widget.onChangePageIndex(0);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "assets/images/support.png",
//                                        height: 20.0,
//                                        width: 20.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "010 481 481 / 012 816 262",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
//                                widget.onChangePageIndex(0);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "assets/images/send.png",
//                                        height: 20.0,
//                                        width: 20.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "poeplenews.asia@gmail.com",
                                        style: TextStyle(
                                            color: ColorsApp.white,
                                            fontSize: 15,
                                            fontFamily: 'khmerosbattambang'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

//                            ListTile(
//                              leading: ImageIcon(
//                                AssetImage("assets/images/call.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              title: Text("010 481 481 / 012 816 262",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'regular')),
//                              onTap: () {
//                                var filter = new Map<String, dynamic>();
//                                /* Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => ProductsWidget(
//                                              filter: filter,
//                                              name: widget.appStateModel.blocks.localeText.localeTextNew)));*/
//                              },
//                            ),
//                            ListTile(
//                              leading: ImageIcon(
//                                AssetImage("assets/images/drawer_6.png"),
//                                size: 20,
//                                color: ColorsApp.white,
//                              ),
//                              title: Text("poeplenews.asia@gmail.com",
//                                  style: TextStyle(
//                                      color: ColorsApp.white,
//                                      fontSize: 12,
//                                      fontFamily: 'regular')),
//                              onTap: () {
//                                var filter = new Map<String, dynamic>();
//                                /* Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => ProductsWidget(
//                                              filter: filter,
//                                              name: widget.appStateModel.blocks.localeText.localeTextNew)));*/
//                              },
//                            ),
                          ],
                        ),
                      ),
                      // The drawer's "details" view.
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*String _getShippingAddress(Address shipping) {
    String address = '';
    if(shipping.address1 != null && shipping.address1.isNotEmpty) {
      address = address + '' + shipping.address1;
    } if(shipping.address2 != null && shipping.address2.isNotEmpty) {
      address = address + ' ' + shipping.address2;
    } if(shipping.city != null && shipping.city.isNotEmpty) {
      address = address + ' ' + shipping.city;
    } if(shipping.postcode != null && shipping.postcode.isNotEmpty) {
      address = address + ' ' + shipping.postcode;
    } if(shipping.state != null && shipping.state.isNotEmpty) {
      address = address + ' ' + shipping.state;
    } if(shipping.country != null && shipping.country.isNotEmpty) {
      address = address + ' ' + shipping.country; }
    return address;
  }*/

  /*TextStyle menuItemStyle() {
    return TextStyle(
        fontFamily: 'Varela',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: Colors.black,
        fontSize: 16
    );
  }*/

}
