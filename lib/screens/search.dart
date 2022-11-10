import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late WebViewController _webViewController;
  TextEditingController _teController = new TextEditingController();
  bool showLoading = false;

  void updateLoading(bool ls) {
    this.setState(() {
      showLoading = ls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFEEEEEE),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFEEEEEE),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Something',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            controller: _teController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          height: 80,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFf36f7c),
                          ),
                          child: Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  String finalURL = _teController.text;
                                  if (!finalURL.startsWith("https://")) {
                                    finalURL = "https://" + finalURL;
                                  }
                                  if (_webViewController != null) {
                                    updateLoading(true);
                                    _webViewController
                                        .loadUrl(finalURL)
                                        .then((onValue) {})
                                        .catchError((e) {
                                      updateLoading(false);
                                    });
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 9,
                  child: Stack(
                    children: <Widget>[
                      WebView(
                        initialUrl: 'http://google.com',
                        onPageFinished: (data) {
                          updateLoading(false);
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (webViewController) {
                          _webViewController = webViewController;
                        },
                      ),
                      (showLoading)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center()
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
