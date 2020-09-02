import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final int selectedUrl;

  const WebViewScreen({Key key, this.selectedUrl}) : super(key: key);
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
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
          child: WebView(
        initialUrl: "http://peoplenews.asia/?p=${widget.selectedUrl}?pvappv=1",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      )),
    )));
  }
}
