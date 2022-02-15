import 'package:flutter/material.dart';

Widget defaultFormField(onChange,){
  return TextFormField(
    onChanged: (value) {
      onChange;
    },
  );
}