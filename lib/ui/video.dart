import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/data.dart';
import 'package:news/ui/SingleVideo.dart';

class Video extends StatefulWidget {
  @override
  videoState createState() => videoState();
}

class videoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    var _width = (MediaQuery.of(context).size.width / 2) - 40;
    // TODO: implement build
    return SafeArea(
      child: Material(
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
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        var link = snapshot.data.data[index]['id'];
                        String title =
                            snapshot.data.data[index]['title']['rendered'];
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final DateTime now =
                            DateTime.parse(snapshot.data.data[index]['date']);
                        final String formatted = formatter.format(now);
                        String date = formatted;
                        var author = snapshot.data.data[index]['author'];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
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
                                  Stack(
                                      alignment: Alignment.bottomRight,
                                      children: <Widget>[
                                        Container(
                                            color: Colors.grey,
                                            height: 120.0,
                                            width: _width,
                                            child: Image.asset(
                                                "assets/images/icon.png")),
                                        Container(
//                                            alignment: Alignment.bottomRight,
                                            child: Image.asset(
                                                "assets/images/playicon.png")),
                                      ]),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: _width + 55,
                                          height: 80.0,
                                          padding: EdgeInsets.only(left: 10.0),
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
                                                  EdgeInsets.only(left: 10.0),
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
    );
    // throw UnimplementedError();
  }
}
