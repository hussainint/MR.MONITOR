import 'dart:convert';

import 'package:MONITOR/download.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int heartRate = -1;
  String temp = "";
  var id = '';
  var name = '';
  var des = '';
  var lati = '';
  var longi = '';
  var createdAt = '';
  var updatedAt = '';
  var uuid = "";
  bool first = true;
  void fetchUsers(var uid) async {
    try {
      final String heartUrl =
          "https://api.thingspeak.com/channels/$uid/fields/1.json?api_key=2T9U9N59D20HA222&results=2";
      final String tempUrl =
          "https://api.thingspeak.com/channels/$uid/fields/2.json?api_key=2T9U9N59D20HA222&results=2";
      setState(() {
        isLoading = true;
      });
      var heartapi = await http.get(heartUrl);
      var kk = json.decode(heartapi.body);
      var tempapi = await http.get(tempUrl);
      var tt = json.decode(tempapi.body);
      print(tt['feeds'][1]['field2']);
      setState(() {
        id = '${kk['channel']['id']}';
        name = '${kk['channel']['name']}';
        des = '${kk['channel']['description']}';
        lati = '${kk['channel']['latitude']}';
        longi = '${kk['channel']['longitude']}';
        createdAt = '${kk['channel']['created_at']}';
        updatedAt = '${kk['channel']['updated_at']}';
        isLoading = false;
        var k1 = '${kk['feeds'][0]['field1']}';
        var k2 = '${kk['feeds'][1]['field1']}';
        var k3;
        if (k2 == '0' || k2 == null)
          k3 = k1;
        else
          k3 = k2;

        heartRate = int.parse('$k3');
        k1 = '${tt['feeds'][0]['field2']}';
        k2 = '${tt['feeds'][1]['field2']}';

        if (k2 == '0' || k2 == 'null')
          k3 = k1;
        else
          k3 = k2;

        temp = k3;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var dt = ModalRoute.of(context).settings.arguments as Map;
    uuid = dt['uid'];
    print(uuid);
    if (first) fetchUsers(uuid);
    first = false;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('MR.MONITOR'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetchUsers(uuid);
              })
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // height:
                            //     (MediaQuery.of(context).size.height - kToolbarHeight) * 0.3,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text2(t1: 'Name', t2: '$name'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'Description', t2: '$des'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'ID', t2: '$id'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'Latitude', t2: '$lati'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'Longitude', t2: '$longi'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'Created At', t2: '$createdAt'),
                                SizedBox(
                                  height: 13,
                                ),
                                Text2(t1: 'Updated At', t2: '$updatedAt'),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: FittedBox(
                            child: Text(
                              'Readings From The Device $heartRate',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Text(
                            'Temperature : $temp',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Heart Rate : $heartRate',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: FittedBox(
                            child: heartRate > 60 && heartRate < 100
                                ? Text(
                                    'Your Heart Rate is Normal',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.green,
                                    ),
                                  )
                                : Text(
                                    'Your Heart Rate is not Normal',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.red,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              color: Colors.blue[900],
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Sign Out',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            MaterialButton(
                              color: Colors.blue[900],
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Download.routeName, arguments: {
                                  'uid': '$uuid',
                                });
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class Text2 extends StatelessWidget {
  var t1, t2;
  Text2({this.t1, this.t2});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: '$t1 :',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        TextSpan(
          text: ' $t2',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ])),
    );
  }
}
