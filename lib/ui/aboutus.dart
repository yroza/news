import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/ui/WebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  @override
  aboutssState createState() => aboutssState();
}

class aboutssState extends State<AboutUs> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Material(
          child: Scaffold(
        body: Container(
            child: WebView(
          initialUrl: "http://peoplenews.asia/about-us?pvappv=1",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        )),
      )),
    );
    // throw UnimplementedError();
  }
}
