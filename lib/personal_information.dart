import 'package:flutter/material.dart';
import 'package:gin_apps/schedule_page.dart';
/*
TBD
 */
class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  bool _passwordVisible = false;
  String passwordStrength = "";
  int passwordLevel = 0;
  bool _passwordValid = false;

  Color passwordColor(int level) {
    Color color = Colors.red;
    if (level == 0) {
      color = Colors.red;
    } else if (level == 1) {
      color = Colors.blue;
    } else if (level == 2) {
      color = Colors.green;
    }
    return color;
  }

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
            TextFormField(
              onChanged: (val) {
                bool strongPassword =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{10,})")
                        .hasMatch(val!);

                bool mediumPassword =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,10})")
                        .hasMatch(val!);
                if (mounted) {
                  setState(() {
                    if (mediumPassword) {
                      passwordLevel = 1;
                      passwordStrength = "Normal";
                      _passwordValid = true;
                    } else if (strongPassword) {
                      passwordLevel = 2;
                      passwordStrength = "Strong";
                      _passwordValid = true;
                    } else {
                      passwordLevel = 0;
                      passwordStrength = "Weak";
                    }
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
                  borderSide: BorderSide(),
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
              height: 15.0,
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
              height: 30.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  if (_passwordValid) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchedulePage(
                                  title: "Create Account",
                                )));
                  } else {
                    final snackBar = SnackBar(
                        content: Text('Password format incorrect or empty'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                color: Colors.cyan,
                minWidth: MediaQuery.of(context).size.width - 50.0,
                child: Text('Next',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )
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
