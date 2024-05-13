import "package:flutter/material.dart";
class ConversionProvider extends ChangeNotifier{
  double _value = 1;
  String _unit;

  ConversionProvider(this._unit);
  double get value=>_value;
  String get unit=>_unit;

  set value(double newValue){
    _value = newValue;
    notifyListeners();
  }

  set unit(newUnit){
    _unit = newUnit;
    notifyListeners();
  }
}