import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/constant/colors.dart';
import 'package:news/constant/data.dart';
import 'package:news/ui/SingleVideo.dart';
import 'package:news/ui/WebView.dart';

class Search extends StatefulWidget {
  @override
  searchState createState() => searchState();
}

class searchState extends State<Search> {
  final myController = TextEditingController();
  String keyword;
  var _width;
  var _height;
  bool _flag = false;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_searchLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  _searchLatestValue() {
    print("Second text field: ${myController.text}");
    setState(() {
      keyword = myController.text;
    });
    if (keyword.length != 0) {
      _flag = true;
    } else {
      _flag = false;
    }
  }

  Widget _searchList() {
    return Container(
      height: _height,
      child: FutureBuilder(
        future: getSearchData(keyword),
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
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final DateTime now =
                          DateTime.parse(snapshot.data.data[index]['date']);
                      final String formatted = formatter.format(now);
                      var data = snapshot.data.data[index]['id'];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          '${snapshot.data.data[index]['author_name']}',
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
                    });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = (MediaQuery.of(context).size.width / 2) - 40;
      _height = (MediaQuery.of(context).size.height - 197);
    });
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(icon: Icon(Icons.search)),
                ),
              ),
              if (_flag) _searchList(),
            ],
          ),
        ),
      ),
    );
    // throw UnimplementedError();
  }
}
