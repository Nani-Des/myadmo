import 'package:flutter/material.dart';
import 'package:my_admo/screens/front_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      title: 'myadmo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: FrontPage(),
    ));
