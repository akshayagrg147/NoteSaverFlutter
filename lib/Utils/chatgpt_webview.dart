import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MyChatGpt extends StatefulWidget {
  const MyChatGpt({Key? key}) : super(key: key);

  @override
  State<MyChatGpt> createState() => _MyChatGptState();
}

class _MyChatGptState extends State<MyChatGpt> {
  final GlobalKey webViewKey = GlobalKey();
  final homeUrl = WebUri("https://chat.openai.com//");
  // final homeUrl = WebUri("https://google.com//");

  InAppWebViewController? webViewController;

  handleClick(int item) async {
    final defaultUserAgent = await InAppWebViewController.getDefaultUserAgent();
    if (kDebugMode) {
      print("Default User Agent: $defaultUserAgent");
    }

    String newUserAgent =defaultUserAgent.replaceFirst("; wv)", ")");

    switch (item) {
      case 0:
        newUserAgent = defaultUserAgent.replaceFirst("; wv)", ")");
        break;
      case 1:
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
          // Remove "wv" from the Android WebView default user agent
          // https://developer.chrome.com/docs/multidevice/user-agent/#webview-on-android
            newUserAgent = defaultUserAgent.replaceFirst("; wv)", ")");
            break;
          case TargetPlatform.iOS:
          // Add Safari/604.1 at the end of the iOS WKWebView default user agent
            newUserAgent = "$defaultUserAgent Safari/604.1";
            break;
          default:
            newUserAgent = defaultUserAgent.replaceFirst("; wv)", ")");
        }
        break;
      case 2:
      // random desktop user agent
        newUserAgent =
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36';
        break;
    }

    if (kDebugMode) {
      print("New User Agent: $newUserAgent");
    }
    await webViewController?.setSettings(
        settings: InAppWebViewSettings(userAgent: newUserAgent));
    await goHome();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration,navigationPage);
  }


  void navigationPage() {
      handleClick(1);
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            "ChatGpt",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xFFf4f4f4),
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  await goHome();
                },
                icon: const Icon(Icons.home)),
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                    value: 0, child: Text('WebView')),
                const PopupMenuItem<int>(
                    value: 1, child: Text('Mobile')),
                const PopupMenuItem<int>(
                    value: 2, child: Text('Desktop')),
              ],
            ),
          ],

        ),

        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: homeUrl),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
          ),
        ]));
  }

  Future<void> goHome() async {
    await webViewController?.loadUrl(urlRequest: URLRequest(url: homeUrl));
  }
}