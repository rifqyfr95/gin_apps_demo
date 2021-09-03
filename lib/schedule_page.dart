import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
/*
TBD
 */
class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Password',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text('Password will be used to login to account',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            SizedBox(
              height: 15.0,
            ),

            SizedBox(
              height: 15.0,
            ),

            SizedBox(
              height: 30.0,
            ),
            Expanded(child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                color: Colors.cyan,
                child: Text('Finish',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
