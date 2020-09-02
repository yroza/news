import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/data.dart';
import 'package:news/ui/WebView.dart';

class TabViewWidget extends StatelessWidget {
  int index;

  TabViewWidget({@required this.index});

  @override
  Widget build(BuildContext context) {
    var _width = (MediaQuery.of(context).size.width / 2) - 40;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return SafeArea(
      child: Material(
        child: Scaffold(
//          appBar: AppBar(
//            backgroundColor: ColorsApp.light_blue,
//          ),
          body: Container(
            child: FutureBuilder(
              future: getHomeData(index),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return ListView.builder(
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data.data[index]['id'];
                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            final DateTime now = DateTime.parse(
                                snapshot.data.data[index]['date']);
                            final String formatted = formatter.format(now);
                            print('>>$data');
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
                                          snapshot.data.data[index]['fimg_url'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: _width + 55,
                                              height: 80.0,
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                '${snapshot.data.data[index]['title']['rendered']}',
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: ColorsApp.light_blue,
                                                    fontFamily:
                                                        'KhmerOSbattambang'),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
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
                                                      fontFamily:
                                                          'KhmerOSbattambang'),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Text(
                                                    'រៀបរៀងដោយ: ',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'KhmerOSbattambang',
                                                        fontSize: 12.0),
                                                  )),
                                              Container(
                                                  child: Text(
                                                '${snapshot.data.data[index]['author_name']}',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily:
                                                        'KhmerOSbattambang'),
                                              )),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
