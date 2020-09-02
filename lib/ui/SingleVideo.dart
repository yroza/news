import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleVideo extends StatefulWidget {
  final int selectedUrl;
  final String title;
  final String date;
  final int author;
  SingleVideo({this.selectedUrl, this.title, this.author, this.date});
  @override
  _SingleVideoState createState() => _SingleVideoState();
}

class _SingleVideoState extends State<SingleVideo> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
//  String url = "https://www.youtube.com/watch?v=b4OH3vBANa4";
  @override
  Widget build(BuildContext context) {
    var _width = (MediaQuery.of(context).size.width / 2) - 40;
    var _height = (MediaQuery.of(context).size.height / 2);
    return SafeArea(
      child: Material(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ColorsApp.light_blue,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height: _height - 124.0,
                      child: WebView(
                        initialUrl:
                            "http://peoplenews.asia/?post_type=video&p=${widget.selectedUrl}?pvappv=1",
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.complete(webViewController);
                        },
                      )),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      height: 85.0,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'KhmerOSbattambang'),
                      )),
                  Divider(
                    thickness: 1.0,
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${widget.date}',
                          style: TextStyle(fontFamily: 'KhmerOSbattambang'),
                        ),
                        Text(
                          '${widget.author}',
                          style: TextStyle(fontFamily: 'KhmerOSbattambang'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: _height - 100,
                    child: FutureBuilder(
                      future: getVideoData(),
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
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, index) {
                                    var link = snapshot.data.data[index]['id'];
                                    String title = snapshot.data.data[index]
                                        ['title']['rendered'];
                                    final DateFormat formatter =
                                        DateFormat('yyyy-MM-dd');
                                    final DateTime now = DateTime.parse(
                                        snapshot.data.data[index]['date']);
                                    final String formatted =
                                        formatter.format(now);
                                    String date = formatted;
                                    var author =
                                        snapshot.data.data[index]['author'];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SingleVideo(
                                                  selectedUrl: link,
                                                  title: title,
                                                  date: date,
                                                  author: author)),
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
                                                child: Image.asset(
                                                    "assets/images/icon.png"),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      width: _width + 55,
                                                      height: 80.0,
                                                      padding: EdgeInsets.only(
                                                          left: 10.0),
                                                      child: Text(
                                                        '${snapshot.data.data[index]['title']['rendered']}',
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: ColorsApp
                                                                .light_blue,
                                                            fontFamily:
                                                                'KhmerOSbattambang'),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              'កាលបរិច្ឆេទ: ',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'KhmerOSbattambang',
                                                                  fontSize:
                                                                      12.0),
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
                                                          padding:
                                                              EdgeInsets.only(
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
                                                        '${snapshot.data.data[index]['author']}',
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
                ],
              ),
            )),
      ),
    );
  }
}
