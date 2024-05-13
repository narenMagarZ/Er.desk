import "package:flutter/material.dart";
class FormSubmissionProvider extends ChangeNotifier{
  bool _isFormSubmissionOnProgress = false;
  bool get isFormSubmissionOnProgress=>_isFormSubmissionOnProgress;
  set isFormSubmissionOnProgress(bool value){
    _isFormSubmissionOnProgress = value;
    notifyListeners();
  }
}
