import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? getDateFormat( DateTime? dt ,{ String pattran ='dd/MM/yyy'}){
  if( dt == null)  return null;
  return DateFormat(pattran).format(dt);
}
showMsg( BuildContext context, String massage ){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(massage)));
}