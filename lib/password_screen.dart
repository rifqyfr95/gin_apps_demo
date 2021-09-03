import 'package:flutter/material.dart';
import 'package:gin_apps/personal_information.dart';
import 'package:gin_apps/widget/stepprogress.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<PasswordPage> {
  bool _passwordVisible = true;
  String password = "";
  String passwordStrength = "";
  String errorText = "";
  int passwordLevel = 0;
  bool _passwordValid = false;
  bool _containLowerCase = false;
  bool _containUpperCase = false;
  bool _containNumber = false;
  bool _containCharacters = false;
  final _stepSize = 4;

  final double _stepCircleRadius = 5.0;

  final _stepProgressViewHeight = 55.0;

  Color _activeColor = Colors.lightGreenAccent;

  Color _inactiveColor = Colors.white;

  int _curPage = 1;

  StepProgressView _getStepProgress() {
    return StepProgressView(
        _stepSize,
        _curPage,
        _stepProgressViewHeight,
        350.0,
        _stepCircleRadius,
        _activeColor,
        _inactiveColor,
        5.0,
        BoxDecoration(color: Theme.of(context).accentColor));
  }

  Color passwordColor(int level) {
    Color color = Colors.red;
    if (level == 0) {
      color = Colors.red;
    } else if (level == 1) {
      color = Colors.yellowAccent;
    } else if (level == 2) {
      color = Colors.lightGreenAccent;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80.0,
              child: _getStepProgress(),
              width: 375.0,
            ),
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
            TextFormField(
              onChanged: (val) {
                bool strongPassword =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{11,})")
                        .hasMatch(val!);
                bool mediumPassword =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{9,10})")
                        .hasMatch(val!);

                _containLowerCase = RegExp(r"^(?=.*[a-z])").hasMatch(val!);
                _containUpperCase = RegExp(r"^(?=.*[A-Z])").hasMatch(val!);
                _containNumber = RegExp(r"^(?=.*[0-9])").hasMatch(val!);
                _containCharacters = RegExp(r"^(?=.{9,})").hasMatch(val!);

                if (mounted) {
                  setState(() {
                    if (strongPassword) {
                      passwordLevel = 2;
                      passwordStrength = "Strong";
                      _passwordValid = true;
                    } else if (mediumPassword) {
                      passwordLevel = 1;
                      passwordStrength = "Normal";
                      _passwordValid = true;
                    } else {
                      passwordLevel = 0;
                      passwordStrength = "Weak";
                    }
                    password = val;
                  });
                }
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "Password cannot be empty";
                }
              },
              keyboardType: TextInputType.text,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Is your password strong?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Text('Complexity : ',
                    style: TextStyle(color: Colors.white, fontSize: 14.0)),
                Text(passwordStrength,
                    style: TextStyle(
                        color: passwordColor(passwordLevel), fontSize: 14.0))
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Is your password format correct?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Icon(
                  _containLowerCase ? Icons.check : Icons.block,
                  color:
                      _containLowerCase ? Colors.lightGreen : Colors.redAccent,
                ),
                SizedBox(width: 5.0),
                Text(
                  "Contains Lowercase",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Icon(
                  _containUpperCase ? Icons.check : Icons.block,
                  color:
                      _containUpperCase ? Colors.lightGreen : Colors.redAccent,
                ),
                SizedBox(width: 5.0),
                Text(
                  "Contains Uppercase",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Icon(
                  _containNumber ? Icons.check : Icons.block,
                  color: _containNumber ? Colors.lightGreen : Colors.redAccent,
                ),
                SizedBox(width: 5.0),
                Text(
                  "Contains Number",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Icon(
                  _containCharacters ? Icons.check : Icons.block,
                  color:
                      _containCharacters ? Colors.lightGreen : Colors.redAccent,
                ),
                SizedBox(width: 5.0),
                Text(
                  "Contains 9+ Characters",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  onPressed: () {
                    if (_passwordValid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalInformationPage(
                                    title: "Create Account",
                                  )));
                    }
                  },
                  color: Colors.cyan,
                  minWidth: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  child: Text('Next',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
