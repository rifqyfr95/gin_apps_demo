import 'package:flutter/material.dart';
import 'package:gin_apps/schedule_page.dart';
import 'package:gin_apps/widget/stepprogress.dart';

class PersonalInformationPage extends StatefulWidget {
  PersonalInformationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  List<String> monthlyIncome = [
    "0-1.000.000",
    "1.000.001-5.000.000",
    "5.000.001-10.000.000",
    "10.000.001-15.000.000",
    "15.000.000++"
  ];
  List<String> monthlyExpenses = [
    "0-1.000.000",
    "1.000.001-5.000.000",
    "5.000.001-10.000.000",
    "10.000.001-15.000.000",
    "15.000.000++"
  ];

  List<String> activationGoals = [
    "Saving",
    "Insurance",
    "Emergency",
    "Investing",
    "Fund"
  ];
  String activationGoal = "Saving";
  String monthlyIncomeChoice = "0-1.000.000";
  String monthlyExpenseChoice = "0-1.000.000";
  int monthlyExpenseVal = 0;
  int monthlyIncomeVal = 0;
  final _stepSize = 4;

  final double _stepCircleRadius = 5.0;

  final _stepProgressViewHeight = 55.0;

  Color _activeColor = Colors.lightGreenAccent;

  Color _inactiveColor = Colors.white;

  int _curPage = 2;

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

  bool formValidity() {
    bool val = false;
    if (activationGoal.isEmpty &&
        monthlyIncomeChoice.isEmpty &&
        monthlyExpenseChoice.isEmpty) {
      val = false;
    } else {
      val = true;
    }
    return val;
  }

  bool balancingIncomeExpense(){
    bool val = false;
    if(monthlyIncomeVal <=monthlyExpenseVal){
      val = false;
    }else{
      val = true;
    }
    return val;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80.0,
              child: _getStepProgress(),
              width: 375.0,
            ),
            Text(
              'Personal Information',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                'Please fill in the information below and your goal for digital saving.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            SizedBox(
              height: 15.0,
            ),
            Text('Activation Goals',
                style: TextStyle(color: Colors.white, fontSize: 14.0)),
            SizedBox(
              height: 15.0,
            ),
            DropdownButton(
                dropdownColor: Theme.of(context).accentColor,
                style: TextStyle(color: Colors.white),
                value: activationGoal,
                onChanged: (val) {
                  setState(() {
                    activationGoal = val.toString();
                  });
                },
                items: activationGoals.map((String activation) {
                  return DropdownMenuItem<String>(
                      value: activation, child: Text(activation));
                }).toList()),
            SizedBox(
              height: 15.0,
            ),
            Text('Monthly Income',
                style: TextStyle(color: Colors.white, fontSize: 14.0)),
            SizedBox(
              height: 15.0,
            ),
            DropdownButton(
                dropdownColor: Theme.of(context).accentColor,
                style: TextStyle(color: Colors.white),
                value: monthlyIncomeChoice,
                onChanged: (val) {
                  setState(() {
                    monthlyIncomeChoice = val.toString();
                    if (monthlyIncomeChoice == "15.000.000++") {
                      monthlyIncomeVal = 5;
                    } else if (monthlyIncomeChoice == "10.000.001-15.000.000") {
                      monthlyIncomeVal = 4;
                    } else if (monthlyIncomeChoice == "5.000.001-10.000.000") {
                      monthlyIncomeVal = 3;
                    } else if (monthlyIncomeChoice == "1.000.001-5.000.000") {
                      monthlyIncomeVal = 2;
                    } else if (monthlyIncomeChoice == "0-1.000.000") {
                      monthlyIncomeVal = 1;
                    } else {
                      monthlyIncomeVal = 0;
                    }
                  });
                },
                items: monthlyIncome.map((String income) {
                  return DropdownMenuItem<String>(
                      value: income, child: Text(income));
                }).toList()),
            SizedBox(
              height: 15.0,
            ),
            Text('Monthly Expense',
                style: TextStyle(color: Colors.white, fontSize: 14.0)),
            SizedBox(
              height: 15.0,
            ),
            DropdownButton(
                dropdownColor: Theme.of(context).accentColor,
                style: TextStyle(color: Colors.white),
                value: monthlyExpenseChoice,
                onChanged: (val) {
                  setState(() {
                    monthlyExpenseChoice = val.toString();
                    if (monthlyExpenseChoice == "15.000.000++") {
                      monthlyExpenseVal = 5;
                    } else if (monthlyExpenseChoice ==
                        "10.000.001-15.000.000") {
                      monthlyExpenseVal = 4;
                    } else if (monthlyExpenseChoice == "5.000.001-10.000.000") {
                      monthlyExpenseVal = 3;
                    } else if (monthlyExpenseChoice == "1.000.001-5.000.000") {
                      monthlyExpenseVal = 2;
                    } else if (monthlyExpenseChoice == "0-1.000.000") {
                      monthlyExpenseVal = 1;
                    } else {
                      monthlyExpenseVal = 0;
                    }
                  });
                },
                items: monthlyExpenses.map((String expense) {
                  return DropdownMenuItem<String>(
                      value: expense, child: Text(expense));
                }).toList()),
            SizedBox(
              height: 30.0,
            ),
            Visibility(
                visible: !balancingIncomeExpense(),
                child: Text(
                  "Your income cannot below your expense values",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  if (formValidity()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchedulePage(
                                  title: "Create Account",
                                )));
                  }
                },
                color: Colors.cyan,
                minWidth: MediaQuery.of(context).size.width - 50.0,
                child: Text('Next',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
