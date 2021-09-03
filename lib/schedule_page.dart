import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:gin_apps/thanks_page.dart';
import 'package:gin_apps/widget/stepprogress.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io' show Platform;

class SchedulePage extends StatefulWidget {
  SchedulePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late AnimationController androAnimationController;
  late AnimationController iosAnimationController;
  late Animation androAnimation;
  late Animation iosAnimation;
  final _stepSize = 4;

  final double _stepCircleRadius = 5.0;

  final _stepProgressViewHeight = 55.0;

  Color _activeColor = Colors.lightGreenAccent;

  Color _inactiveColor = Colors.white;

  int _curPage = 3;

  DateTime dateTime = DateTime.now();
  String selectedTime = "";

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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
            SizedBox(
              height: 80.0,
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Platform.isAndroid
                      ? AnimatedBuilder(
                          animation: androAnimationController,
                          builder: (context, child) {
                            return Container(
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.6),
                                shape: CircleBorder(),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    7.0 * androAnimationController.value),
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.blue,
                              icon:
                                  Icon(Icons.calendar_today_rounded, size: 24),
                            ),
                          ),
                        )
                      : AnimatedBuilder(
                          animation: androAnimationController,
                          builder: (context, child) {
                            return Container(
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.6),
                                shape: CircleBorder(),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    7.0 * androAnimationController.value),
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              color: Colors.blue,
                              icon: Icon(CupertinoIcons.calendar, size: 24),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Text(
              'Schedule Video Call',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
                'Choose the date and time that you preferred, we will send you a link via email to make a video call on the scheduled date and time.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            SizedBox(
              height: 15.0,
            ),
            Text('Date', style: TextStyle(color: Colors.white, fontSize: 18.0)),
            TextFormField(
              controller: dateController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Choose Date",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_downward_sharp),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          if (Platform.isAndroid) {
                            _dateSelector(context);
                          } else if (Platform.isIOS) {
                            _iosDateSelector(context);
                          }
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
            Text('Time', style: TextStyle(color: Colors.white, fontSize: 18.0)),
            TextFormField(
              controller: timeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Choose Time",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_downward_sharp),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          if (Platform.isAndroid) {
                            _timePicker(context);
                          } else if (Platform.isIOS) {
                            _iosTimeSelector(context);
                          }
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
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThanksPage(
                            title: "Create Account",
                          )));
                },
                color: Colors.cyan,
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
    if (Platform.isAndroid) {
      androAnimationController =
          AnimationController(vsync: this, duration: Duration(seconds: 1))
            ..forward()
            ..repeat(reverse: true);
    } else if (Platform.isIOS) {
      iosAnimationController =
          AnimationController(vsync: this, duration: Duration(seconds: 1))
            ..forward()
            ..repeat(reverse: true);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isAndroid) {
      androAnimationController.dispose();
    } else if (Platform.isIOS) {
      iosAnimationController.dispose();
    }
    super.dispose();
  }

  _dateSelector(BuildContext context) async {
    await initializeDateFormatting('id_ID', null);
    final DateTime? picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picker != null && picker != dateTime)
      setState(() {
        dateTime = picker;
        DateFormat dateFormat = DateFormat("EEEE, d MMMM yyyy", "id_ID");
        dateController.text = dateFormat.format(dateTime);
        FocusManager.instance.primaryFocus?.unfocus();
      });
  }

  _iosDateSelector(BuildContext context) async {
    await initializeDateFormatting('id_ID', null);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picker) {
                if (picker != null && picker != dateTime)
                  setState(() {
                    dateTime = picker;
                    DateFormat dateFormat =
                        DateFormat("EEEE, d MMMM yyyy", "id_ID");
                    dateController.text = dateFormat.format(dateTime);
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
              },
              initialDateTime: dateTime,
              minimumYear: 2000,
              maximumYear: 2030,
            ),
          );
        });
  }

  Future<void> _timePicker(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });
    if (result != null) {
      setState(() {
        selectedTime = "${result.hour}:${result.minute}";
        timeController.text = selectedTime;
        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }

  _iosTimeSelector(BuildContext context) async {
    await initializeDateFormatting('id_ID', null);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (picker) {
                if (picker != null && picker != dateTime)
                  setState(() {
                    var newTod = TimeOfDay.fromDateTime(picker);
                    timeController.text = "${newTod.hour}:${newTod.minute}";
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
              },
              initialDateTime: dateTime,
              minimumYear: 2000,
              maximumYear: 2030,
            ),
          );
        });
  }
}
