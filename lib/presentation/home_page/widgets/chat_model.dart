import 'package:flutter/material.dart';

chatMessageModel({required String msg, required bool isUser}) => !isUser
    ? Container(
        margin: const EdgeInsets.only(right: 40, top: 5, bottom: 5),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Text(msg),
      )
    : Container(
        margin: const EdgeInsets.only(left: 40, top: 5, bottom: 5),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Text(msg),
      );
