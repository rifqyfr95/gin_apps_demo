import 'package:flutter/material.dart';
/*
Based from :
https://stacksecrets.com/flutter/building-a-step-progress-indicator-view-in-flutter

Modified by RFR
 */

class StepProgressView extends StatelessWidget {
  const StepProgressView(
      int stepSize,
      int curStep,
      double height,
      double width,
      double dotRadius,
      Color activeColor,
      Color inactiveColor,
      double lineHeight,
      BoxDecoration decoration)  :
        _curStep = curStep,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _decoration = decoration,
        _stepSize = stepSize,
        _lineHeight = lineHeight,
        assert(curStep <= stepSize),
        assert(width > 0),
        assert(stepSize > 0),
        assert(lineHeight > 0),
        assert(height >= 2 * dotRadius);


  //height of the container
  final double _height;
  //color of box decoration
  final BoxDecoration _decoration;
  //width of the container
  final double _width;
  //cur step identifier
  final int _curStep;
  //active color
  final Color _activeColor;
  //in-active color
  final Color _inactiveColor;
  //dot radius
  final double _dotRadius;
  //line height
  final double _lineHeight;
  //step size
  final int _stepSize;

  List<Widget> _buildDots() {
    var wids = <Widget>[];
    for (int i = 0;i<_stepSize;i++){

      var circleColor = _inactiveColor;
      if(_curStep == 0){
        circleColor = _inactiveColor;
      }else{
        circleColor = (i == 0 || _curStep > i  ) ? _activeColor : _inactiveColor;
      }


      wids.add(CircleAvatar(
        backgroundColor: Colors.black54,
        radius: 30,
        child: CircleAvatar(
          backgroundColor: circleColor,
          radius: 25,
          child: Text("${i+1}", style: TextStyle(color: Colors.black),),
        )
      ));

      //add a line separator
      //0-------0--------0
      if (i != _stepSize - 1) {
        wids.add(
          Expanded(
            child: Container(
              height: _lineHeight,
              color: Colors.black,
            ),
          ),
        );
      }
    }

    return wids;
  }


  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: this._height,
      width: this._width,
      decoration: this._decoration,
      child: Column(
        children: <Widget>[

          Row(
            children: _buildDots(),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}