import 'package:flutter/material.dart';
import 'package:gin_apps/password_screen.dart';
import 'package:gin_apps/widget/stepprogress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIN Finance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(
        title: "GIN Finance",
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _validEmail = false;

  TextEditingController emailController = TextEditingController();

  final _stepSize = 4;

  final double _stepCircleRadius = 5.0;

  final _stepProgressViewHeight = 100.0;

  Color _activeColor = Colors.lightGreen;

  Color _inactiveColor = Colors.white;

  int _curPage = 0;

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
        BoxDecoration(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 125.0, child: _getStepProgress(), width: 375.0),
            Text(
              'Welcome to',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GIN ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold)),
                Text("Finance",
                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                'Welcome to The Bank of The Future.\nManage and track your accounts on the go',
                style: TextStyle(color: Colors.cyan, fontSize: 18.0)),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: emailController,
              onChanged: (val) {
                bool validator = RegExp(
                        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(val!);
                if (val!.isEmpty) {
                  _validEmail = false;
                } else if (!validator) {
                  _validEmail = false;
                } else {
                  if (mounted) {
                    setState(() {
                      _validEmail = true;
                    });
                  }
                }
              },
              decoration: InputDecoration(
                labelText: "Email",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  if (_validEmail) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordPage(
                                  title: "Create Account",
                                )));
                  } else {
                    final snackBar = SnackBar(
                        content: Text('Email empty or incorrect format'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                color: Colors.cyan,
                minWidth: MediaQuery.of(context).size.width - 50.0,
                child: Text('Next',
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
    // TODO: implement initState
    super.initState();
  }
}
