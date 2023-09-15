import 'package:attendo/screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction{Confirm}
// ignore: camel_case_types
class showAttendanceMarkedSuccess{
  // ignore: non_constant_identifier_names
  static Future<DialogAction> ConfirmDialog(
      BuildContext context,
      String title,
      String courseName,
      ) async{
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Icon(Icons.check, size: 40, color: Colors.green,),
              content: Text("AhhhhTendo! You have Successfully marked your Attendance for " + courseName , style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () => Navigator.of(context).pop(DialogAction.Confirm),
                    color: PrimaryColor,
                    child: const Text('Confirm')
                ),
              ]
          );
        }
    );
    return action; //change according
  }
}

class showAttendanceUploadedSuccess{
  // ignore: non_constant_identifier_names
  static Future<DialogAction> ConfirmDialog(
      BuildContext context,
      String title,
      String courseName,
      ) async{
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Icon(Icons.check, size: 40, color: Colors.green,),
              content: Text("AhhhhTendo! You have Successfully uploaded the Attendance for " + courseName , style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              actions: <Widget>[
                RaisedButton(
                    onPressed: () => Navigator.of(context).pop(DialogAction.Confirm),
                    color: PrimaryColor,
                    child: const Text('Confirm')
                ),
              ]
          );
        }
    );
    return action; //change according
  }
}