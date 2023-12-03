

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_style.dart';

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Read More Text',
          )),
      body:  const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),

            ),
          ],
        ),
      ),
    );
  }
}