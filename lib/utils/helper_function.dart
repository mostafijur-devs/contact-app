import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? getDateFormat( DateTime? dt ,{ String pattran ='yyy-MM-dd'}){
  if( dt == null)  return null;
  return DateFormat(pattran).format(dt);
}
showMsg( BuildContext context, String massage ){
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(massage)));
}