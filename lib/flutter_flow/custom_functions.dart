import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String positionCall(String positionTitle) {
  // Add your function code here!
  // if produceMeat == true print Produce & Meat Assocaite
  if (positionTitle == 'produceMeat') {
    return 'Produce & Meat Assocaite';
  } else {
    return '';
  }
}
