import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clipboard/clipboard.dart';

class Download extends StatefulWidget {
  static const routeName = "/down";

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  String uuid = "";
  String output = "....";
  String pathh = "";
  String data1 = "...", data2 = "...";
  TextEditingController numm = TextEditingController();
  bool showProgress = false;
  void saveFile(String uid, int k) async {
    final String heartUrl =
        "https://api.thingspeak.com/channels/$uid/fields/1.json?api_key=2T9U9N59D20HA222&results=${numm.text}";
    final String tempUrl =
        "https://api.thingspeak.com/channels/$uid/fields/2.json?api_key=2T9U9N59D20HA222&results=${numm.text}";
    var kk;
    var s = "";

    var heartapi = await http.get(heartUrl);
    kk = json.decode(heartapi.body);

    heartapi = await http.get(tempUrl);
    var kk1 = json.decode(heartapi.body);
    var p1 = "", p2 = "";
    for (int i = 0; i < kk['feeds'].length; i++) {
      p1 = p1 +
          '${kk['feeds'][i]['created_at']} : ${kk['feeds'][i]['field1']}' +
          '\n\n';
    }
    for (int i = 0; i < kk1['feeds'].length; i++) {
      p2 = p2 +
          '${kk1['feeds'][i]['created_at']} : ${kk1['feeds'][i]['field2']}' +
          '\n\n';
    }

    setState(() {
      data1 = "$p1";
      data2 = '$p2';
      showProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dt = ModalRoute.of(context).settings.arguments as Map;
    uuid = '${dt['uid']}';
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('MR.MONITOR'),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FittedBox(
                    child: Text(
                      'Download Your Data',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: Text(
                        'How Many Data\n Do You Need :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        controller: numm,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: Colors.blue[900],
                  onPressed: () {
                    setState(() {
                      showProgress = true;
                    });
                    saveFile(uuid, 1);
                  },
                  child: FittedBox(
                    child: Text(
                      'Get Data',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Heart Rate',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.file_download),
                          onPressed: () {
                            FlutterClipboard.copy('$data1').then((value) {
                              final snackBar = SnackBar(
                                  content: Text('Heart Rate Data Copied'));
                              Scaffold.of(ctx).showSnackBar(snackBar);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Temeperature',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.file_download),
                          onPressed: () {
                            FlutterClipboard.copy('$data2').then((value) {
                              final snackBar = SnackBar(
                                  content: Text('Temperature Data Copied'));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                              Scaffold.of(ctx).showSnackBar(snackBar);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                showProgress
                    ? CircularProgressIndicator()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Text(
                              '$data1',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          VerticalDivider(),
                          Flexible(
                            child: Text(
                              '$data2',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
