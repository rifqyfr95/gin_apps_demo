import 'package:flutter/material.dart';
import 'package:gin_apps/widget/stepprogress.dart';
import 'package:flutter/services.dart';



class ThanksPage extends StatefulWidget {
  ThanksPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ThanksPageState createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  bool _validEmail = false;

  TextEditingController emailController = TextEditingController();

  final _stepSize = 4;

  final double _stepCircleRadius = 5.0;

  final _stepProgressViewHeight = 55.0;

  Color _activeColor = Colors.lightGreen;

  Color _inactiveColor = Colors.white;

  int _curPage = 4;

  StepProgressView _getStepProgress() {
    return StepProgressView(
        _stepSize,
        _curPage,
        _stepProgressViewHeight,
        375.0,
        _stepCircleRadius,
        _activeColor,
        _inactiveColor,
        5.0,
        BoxDecoration(color: Theme.of(context).accentColor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80.0, child: _getStepProgress(), width: 375.0),
            SizedBox(
              height: 100.0,
            ),
            Text('Thanks!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            Text(
                'We glad that we can become your choice of digital banking, We will inform you the detail about our banking service via email soon.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            SizedBox(
              height: 15.0,
            ),

            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    onPressed: () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    color: Colors.cyan,
                    minWidth: MediaQuery.of(context).size.width - 50.0,
                    child: Text('Quit',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                )),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
