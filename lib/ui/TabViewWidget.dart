import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/data.dart';
import 'package:news/ui/WebView.dart';
import 'package:dio/dio.dart';
import 'package:news/constant/endpoint.dart';
import 'package:loadmore/loadmore.dart';

class TabViewWidget extends StatefulWidget {
  int index;
  TabViewWidget({this.index});
  @override
  _TabViewWidgetState createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget> {
//  int index;
  ScrollController _scrollController = new ScrollController();
  int page = 1;
  List _val = new List();
  bool isLoading = false;

  @override
  void initState() {
    load(widget.index, page);

    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        load(widget.index, page);
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        _refresh();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void load(int index, int page) async {
//  Map<String, dynamic> data;
    Response response;
//    List _val;
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        response = await Dio().get(Endpoint.category, queryParameters: {
          "categories": index,
          "per_page": 10,
          "page": page
        });
        List tList = new List();
        tList = response.data;
        print('...>>${tList[0]}');
        setState(() {
          isLoading = false;
          _val.addAll(tList);
          page++;
        });
//    print(' Category.. DATA : >> ${response.data[0]['date']}');
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    setState(() {
      page = page + 1;
    });
    getHomeData(widget.index, page);
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    _val.clear();
    load(widget.index, page);
  }

  void _increment() {
    setState(() {
      page = page + 1;
    });
    getHomeData(widget.index, page);
  }

  @override
  Widget build(BuildContext context) {
    var _width = (MediaQuery.of(context).size.width / 2) - 40;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    print('build$_val');
    return SafeArea(
      child: Material(
        child: Scaffold(
//          appBar: AppBar(
//            backgroundColor: ColorsApp.light_blue,
//          ),
          body: Container(
//            child: FutureBuilder(
//              future: getHomeData(widget.index, page),
//              builder: (BuildContext context, AsyncSnapshot snapshot) {
//                switch (snapshot.connectionState) {
//                  case ConnectionState.none:
//                  case ConnectionState.waiting:
//                    return Center(child: CircularProgressIndicator());
//                  default:
//                    if (snapshot.hasError)
//                      return new Text('Error: ${snapshot.error}');
//                    else
//                      return
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _val.length,
                itemBuilder: (context, index) {
                  var data = _val[index]['id'];
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final DateTime now = DateTime.parse(_val[index]['date']);
                  final String formatted = formatter.format(now);
                  print('>>$data');
                  if (index == _val.length) {
                    return CircularProgressIndicator();
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewScreen(
                                    selectedUrl: data,
                                  )),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                color: Colors.grey,
                                height: 120.0,
                                width: _width,
                                child: Image.network(
                                  _val[index]['fimg_url'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: _width + 55,
                                      height: 80.0,
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        '${_val[index]['title']['rendered']}',
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: ColorsApp.light_blue,
                                            fontFamily: 'KhmerOSbattambang'),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              'កាលបរិច្ឆេទ: ',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'KhmerOSbattambang',
                                                  fontSize: 12.0),
                                            )),
                                        Container(
                                            child: Text(
                                          formatted,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'KhmerOSbattambang'),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'រៀបរៀងដោយ: ',
                                            style: TextStyle(
                                                fontFamily: 'KhmerOSbattambang',
                                                fontSize: 12.0),
                                          )),
                                      Container(
                                          child: Text(
                                        '${_val[index]['author_name']}',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'KhmerOSbattambang'),
                                      )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  }
                }),
//                }
//              },
//            ),
          ),
        ),
      ),
    );
  }
}
